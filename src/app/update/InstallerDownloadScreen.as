package app.update
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
  import flash.system.Capabilities;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLStream;
  import flash.utils.setTimeout;
  import flash.utils.ByteArray;
  import app.StatusText;

  public class InstallerDownloadScreen extends Sprite
  {
    private var status:StatusText     = new StatusText();
    private var urlStream:URLStream   = new URLStream();
    private var fileStream:FileStream = new FileStream();
    private var file:File             = new File();

    public function InstallerDownloadScreen(installerFilename:String)
    {
      status.setText("Downloading update ...");
      addChild(status);

      //file = File.createTempDirectory().resolvePath(CONFIG::installerFilename);
      // TODO: how to clean up temp directory?
      file = File.applicationStorageDirectory.resolvePath(installerFilename);

      urlStream.addEventListener(Event.OPEN,             handleOpenEvent);
      urlStream.addEventListener(ProgressEvent.PROGRESS, handleProgressEvent);
      urlStream.addEventListener(Event.COMPLETE,         handleCompleteEvent);
      urlStream.addEventListener(IOErrorEvent.IO_ERROR,  handleIoError);

      var urlRequest:URLRequest = new URLRequest(CONFIG::installerSite + installerFilename);
      urlStream.load(urlRequest);
    }

    private function removeListeners():void
    {
      urlStream.removeEventListener(Event.OPEN,             handleOpenEvent);
      urlStream.removeEventListener(ProgressEvent.PROGRESS, handleProgressEvent);
      urlStream.removeEventListener(Event.COMPLETE,         handleCompleteEvent);
      urlStream.removeEventListener(IOErrorEvent.IO_ERROR,  handleIoError);
    }

    private function handleOpenEvent(event:Event):void
    {
trace("handle open event");
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
      removeListeners();
      fileStream.close();
      urlStream.close();
      if (Capabilities.os.substr(0, 3) == "Mac")
      {
        parent.addChild(new MountOsxInstallerScreen(file));
      }
      else
      {
        parent.addChild(new RunInstallerScreen(file));
      }
      parent.removeChild(this);
    }

    private function handleIoError(event:IOErrorEvent):void
    {
      removeListeners();
      fileStream.close();
      urlStream.close();
      status.setText("InstallerDownloadScreen: IO error: " + event.text);
    }
  }
}

