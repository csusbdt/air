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
    private var urlLoader:URLLoader = new URLLoader();
    private var status:StatusText = new StatusText();

    public static function getDownloadFile():File
    {
      var filename:String = "temp" + (CONFIG::os === "osx" ? ".dmg" : ".msi");
      return File.applicationStorageDirectory.resolvePath(filename);
    }

    private static function getInstallerURLURL():String
    {
      return CONFIG::installerSite + "/hello-air-" + CONFIG::os;
    }

    private static function getInstallerURL():String
    {
      return CONFIG::installerSite + "/hello-air-" + CONFIG::versionNumber + 
             (CONFIG::os === "osx" ? ".dmg" : ".msi");
    }

    public function UpdateStartScreen():void
    {
      self = this;
      status.setText("Deleting previous installer...");
      addChild(status);
      setTimeout(cleanup, 2000);
    }
	
    private function cleanup():void
    {
      var file:File = getDownloadFile();
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
        urlLoader.load(new URLRequest(getInstallerURLURL()));
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
trace(installerURL);
trace(getInstallerURL());
      if (installerURL === getInstallerURL())
      {
        status.setText("Application is up to date.");
        setTimeout(gotoTitleScreen, 2000);
      }
      else
      {
        app.Util.gotoScreen(self, UpdateDownloadScreen, installerURL);
      }
    }
	
    private function gotoTitleScreen():void
    {
      app.Util.gotoScreen(self, TitleScreen);
    }
  }
}
