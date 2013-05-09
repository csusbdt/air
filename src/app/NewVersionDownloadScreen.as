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

  public class NewVersionDownloadScreen extends Screen
  {
    private var status:TextField = new TextField();

    private var urlLoader:URLLoader = new URLLoader();

    private function trim(s:String):String
    {
      return s.replace(/^\s+|\s+$/gs, "");
    }

    public function NewVersionDownloadScreen()
    {
      status.defaultTextFormat = textFormat;
      status.autoSize          = TextFieldAutoSize.LEFT;
      status.text              = "Downloading update ...";
      status.x                 = 50;
      status.y                 = 50;
      addChild(status);
      attachListeners();

      urlStream = new URLStream;
      urlStream.addEventListener(Event.OPEN, urlStream_openHandler);
      urlStream.addEventListener(ProgressEvent.PROGRESS, urlStream_progressHandler);
      urlStream.addEventListener(Event.COMPLETE, urlStream_completeHandler);
      urlStream.addEventListener(IOErrorEvent.IO_ERROR, urlStream_ioErrorHandler);
      urlStream.load(new URLRequest(updateUrl));

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

