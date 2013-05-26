package app.update
{
  import flash.display.Sprite;
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
   * then the application is up-to-date, and the screen transitions 
   * to the title screen.  If the urls don't match, then the new
   * version of the application will be installed, and the
   * screen transitions to the download installer screen.
   */
  public class VersionCheckScreen extends Sprite
  {
    private var self:VersionCheckScreen;
    private var urlLoader:URLLoader = new URLLoader();
    private var status:StatusText = new StatusText();

    public function VersionCheckScreen()
    {
      self = this;
      status.setText("Checking for updates...");
      addChild(status);
      setTimeout(init, 2000);
    }

    private function init():void
    {
      urlLoader.addEventListener(Event.COMPLETE, onComplete);
      urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
      try
      {
        urlLoader.load(new URLRequest(CONFIG::installerURLURL));
      }
      catch(error:Error)
      {
        status.setText(error.message);
      }
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
      if (installerURL === CONFIG::installerURL)
      {
        gotoTitleScreen();
      }
      else
      {
        app.Util.gotoScreen(self, InstallerDownloadScreen, installerURL);
      }
    }
	
    private function gotoTitleScreen():void
    {
      app.Util.gotoScreen(self, TitleScreen);
    }
  }
}
