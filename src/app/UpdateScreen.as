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

  public class UpdateScreen extends Screen
  {
    private var status:TextField = new TextField();

    private var updateDescriptorLoader:URLLoader = new URLLoader();

    private function trim(s:String):String
    {
      return s.replace(/^\s+|\s+$/gs, "");
    }

    public function UpdateScreen()
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
        updateDescriptorLoader.load(new URLRequest(CONFIG::versionUrl));
      }
      catch(error:Error)
      {
        status.text = error.message;
      }
    }

    private function attachListeners():void
    {
      updateDescriptorLoader.addEventListener(Event.COMPLETE, updateDescriptorLoaderComplete);
      updateDescriptorLoader.addEventListener(IOErrorEvent.IO_ERROR, updateDescriptorLoaderIoError);
    }

    private function detachListeners():void
    {
      updateDescriptorLoader.removeEventListener(Event.COMPLETE, updateDescriptorLoaderComplete);
      updateDescriptorLoader.removeEventListener(IOErrorEvent.IO_ERROR, updateDescriptorLoaderIoError);
    }

    private function updateDescriptorLoaderIoError(event:IOErrorEvent):void
    {
      detachListeners();
      updateDescriptorLoader.close();
      status.text = "IO error";
    }

    private function updateDescriptorLoaderComplete(event:Event):void
    {
      detachListeners();
      updateDescriptorLoader.close();
      var versionNumber:String = updateDescriptorLoader.data;
      if (trim(versionNumber) === CONFIG::versionNumber)
      {
        status.text = "Version number good.";
      }
      else
      {
        status.text = "Need to update to version " + versionNumber;
      }
    }
  }
}

