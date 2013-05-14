package app.update
{
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;

  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;

  import flash.utils.Timer;
  import flash.events.TimerEvent;
  import app.Screen;

  /**
   * This class checks to see that the name of the installer used
   * to install the currently running program (myInstallerName)  
   * matches the installer on the application's website
   * (currentInstallerName).  If the names match, then the 
   * application is up-to-date, and the screen transitions to the 
   * title screen.  If the names don't match, then the new
   * version of the application will be installed, and the
   * screen transitions to the download installer screen.
   */
  public class VersionCheckScreen extends Screen
  {
    private var status:TextField = new TextField();
    private var urlLoader:URLLoader = new URLLoader();

    public function VersionCheckScreen()
    {
      status.defaultTextFormat = textFormat;
      status.autoSize          = TextFieldAutoSize.LEFT;
      status.text              = "Checking for updates...";
      status.x                 = 50;
      status.y                 = 50;
      addChild(status);
      urlLoader.addEventListener(Event.COMPLETE, handleCompleteEvent);
      urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleIoErrorEvent);
      var url:String = CONFIG::installerSite + CONFIG::installerFilenameResource;
      try
      {
        urlLoader.load(new URLRequest(url));
      }
      catch(error:Error)
      {
        status.text = error.message;
        return;
      }
    }

    private function detachListeners():void
    {
      urlLoader.removeEventListener(Event.COMPLETE, handleCompleteEvent);
      urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, handleIoErrorEvent);
    }

    private function handleIoErrorEvent(event:IOErrorEvent):void
    {
      detachListeners();
      urlLoader.close();
      status.text = "VersionCheckScreen: IO error: " + event.text;
    }

    private function handleCompleteEvent(event:Event):void
    {
      detachListeners();
      urlLoader.close();
      var installerFilename:String = trim(urlLoader.data);
      if (installerFilename === CONFIG::installerFilename)
      {
        parent.addChild(new app.TitleScreen());
      }
      else
      {
        parent.addChild(new InstallerDownloadScreen(installerFilename));
      }
      parent.removeChild(this);
    }
  }
}

