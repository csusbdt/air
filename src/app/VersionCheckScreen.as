package app
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

  public class VersionCheckScreen extends Screen
  {
    private var status:TextField = new TextField();

    private var urlLoader:URLLoader = new URLLoader();

    private function trim(s:String):String
    {
      return s.replace(/^\s+|\s+$/gs, "");
    }

    public function VersionCheckScreen()
    {
      status.defaultTextFormat = textFormat;
      status.autoSize          = TextFieldAutoSize.LEFT;
      status.text              = "Checking for updates...";
      status.x                 = 50;
      status.y                 = 50;
      addChild(status);
      attachListeners();
      try
      {
        urlLoader.load(new URLRequest(CONFIG::versionUrl));
      }
      catch(error:Error)
      {
        status.text = error.message;
      }
    }

    private function attachListeners():void
    {
      urlLoader.addEventListener(Event.COMPLETE, handleCompleteEvent);
      urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleIoErrorEvent);
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
      status.text = "IO error";
    }

    private function handleCompleteEvent(event:Event):void
    {
      detachListeners();
      urlLoader.close();
      var versionNumber:String = urlLoader.data;
      if (trim(versionNumber) === CONFIG::versionNumber)
      {
        parent.addChild(new TitleScreen());
      }
      else
      {
        parent.addChild(new NewVersionDownloadScreen());
      }
      parent.removeChild(this);
    }
  }
}

