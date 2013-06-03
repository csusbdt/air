package app.desktop.native
{
  import flash.display.Sprite;
  import flash.filesystem.File;
  import flash.filesystem.FileStream;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.utils.setTimeout;
  
  import air.update.ApplicationUpdater;
  
  import app.Util;
  import app.TitleScreen;
  import app.StatusText;

  /**
   * This class checks to see that the url of the installer used
   * to install the currently running program matches the 
   * installer on the application's website. If the urls match, 
   * then the application is up-to-date.  If the urls don't match, 
   * the installer is downloaded and launched.
   */
  public class UpdateStartScreen extends Sprite
  {
    private var self:UpdateStartScreen;
    private var os:String;
    private var urlLoader:URLLoader = new URLLoader();
    private var status:StatusText = new StatusText();

    public static function getDownloadFile(os:String):File
    {
      var filename:String = "temp" + (os === "osx" ? ".dmg" : ".exe");
      return File.applicationStorageDirectory.resolvePath(filename);
    }

    private static function getInstallerURLURL(os:String):String
    {
      return CONFIG::installerSite + "/hello-air-native-" + os;
    }

    private static function getInstallerURL(os:String):String
    {
      return CONFIG::installerSite + "/hello-air-native-" + os + "-" + new ApplicationUpdater().currentVersion + 
             (os === "osx" ? ".dmg" : ".exe");
    }

    public function UpdateStartScreen(os:String):void
    {
      self = this;
      this.os = os;
      status.setText("Deleting previous installer.");
      addChild(status);
      setTimeout(cleanup, 2000);
    }
	
    private function cleanup():void
    {
      var file:File = getDownloadFile(os);
      if (file.exists) 
      { 
        try { file.deleteFile(); } catch (e:Error) { } 
      }
      status.setText("Checking for updates...");
      setTimeout(checkVersion, 2000);
    }

    private function checkVersion():void
    {
      addListeners();
      try
      {
        urlLoader.load(new URLRequest(getInstallerURLURL(os)));
      }
      catch(error:Error)
      {
        status.setText(error.message);
        removeListeners();
      }
    }

    private function addListeners():void
    {
      urlLoader.addEventListener(Event.COMPLETE, onComplete);
      urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
    }

    private function removeListeners():void
    {
      urlLoader.removeEventListener(Event.COMPLETE, onComplete);
      urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
    }

    private function onIoError(event:IOErrorEvent):void
    {
      removeListeners();
      urlLoader.close();
      status.setText("Connection Error");
      setTimeout(gotoTitleScreen, 2000);
    }

    private function onComplete(event:Event):void
    {
      removeListeners();
      urlLoader.close();
      var installerURL:String = Util.trim(urlLoader.data);
      if (installerURL === getInstallerURL(os))
      {
        status.setText("Application is up to date.");
        setTimeout(gotoTitleScreen, 2000);
      }
      else
      {
        app.Util.gotoScreen(self, UpdateDownloadScreen, os, installerURL);
      }
    }
	
    private function gotoTitleScreen():void
    {
      app.Util.gotoScreen(self, TitleScreen);
    }
  }
}
