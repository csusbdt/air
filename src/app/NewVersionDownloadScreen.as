package app
{
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;

import flash.desktop.NativeApplication;
import flash.desktop.NativeProcess;
import flash.desktop.NativeProcessStartupInfo;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLStream;
import flash.utils.ByteArray;

  public class NewVersionDownloadScreen extends Screen
  {
    private var status:TextField = new TextField();

    private var urlStream:URLStream = new URLStream();
    private var fileStream:FileStream = new FileStream;
    private var file:File = new File();

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

      var fileName:String = "hello-air.dmg";
      var file:File = File.createTempDirectory().resolvePath(fileName);

      attachListeners();
      var url:String = CONFIG::installerSite + CONFIG::installerFilename;
      urlStream.load(new URLRequest(CONFIG::url));
    }

    private function attachListeners():void
    {
      urlStream.addEventListener(Event.OPEN,             handleOpenEvent);
      urlStream.addEventListener(ProgressEvent.PROGRESS, handleProgressEvent);
      urlStream.addEventListener(Event.COMPLETE,         handleCompleteEvent);
      urlStream.addEventListener(IOErrorEvent.IO_ERROR,  handleIoErrorEvent);
    }

    private function detachListeners():void
    {
      urlStream.removeEventListener(Event.OPEN,             handleOpenEvent);
      urlStream.removeEventListener(ProgressEvent.PROGRESS, handleProgressEvent);
      urlStream.removeEventListener(Event.COMPLETE,         handleCompleteEvent);
      urlStream.removeEventListener(IOErrorEvent.IO_ERROR,  handleIoErrorEvent);
    }

    private function handleOpenEvent(event:Event):void
    {
      fileStream.open(file, FileMode.WRITE);
    }

    private function handleProgressEvent(event:ProgressEvent):void
    {
      var loadedBytes:ByteArray = new ByteArray();
      urlStream.readBytes(loadedBytes);
      fileStream.writeBytes(loadedBytes);
    }

    private function handleCompleteEvent(event:Event):void
    {
      closeStreams();
      installUpdate();
    }

    private function handleIoErrorEvent(event:IOErrorEvent):void
    {
      detachListeners();
// CLOSE STUFF
      status.text = "IO error";
    }

    protected function installUpdate():void
    {
      var info:NativeProcessStartupInfo = new NativeProcessStartupInfo;
      info.executable = updateFile;
      var process:NativeProcess = new NativeProcess;
      process.start(info);
      NativeApplication.nativeApplication.exit();
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

