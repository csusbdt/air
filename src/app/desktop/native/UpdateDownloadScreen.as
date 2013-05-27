package app.desktop.native
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLStream;
  import flash.utils.setTimeout;
  import flash.utils.ByteArray;
  import app.StatusText;

  public class UpdateDownloadScreen extends Sprite
  {
    private var self:UpdateDownloadScreen;
    private var installerURL:String;
    private var status:StatusText     = new StatusText();
    private var urlStream:URLStream   = new URLStream();
    private var fileStream:FileStream = new FileStream();

    public function UpdateDownloadScreen(installerURL:String)
    {
      self = this;
      this.installerURL = installerURL;
      status.setText("Downloading update.");
      addChild(status);
      setTimeout(download, 2000);
    }
  
    private function download():void
    {
      addListeners();
      urlStream.load(new URLRequest(installerURL));
    }

    private function addListeners():void
    {
      urlStream.addEventListener(Event.OPEN,             onOpen);
      urlStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
      urlStream.addEventListener(Event.COMPLETE,         onComplete);
      urlStream.addEventListener(IOErrorEvent.IO_ERROR,  onIoError);
    }

    private function removeListeners():void
    {
      urlStream.removeEventListener(Event.OPEN,             onOpen);
      urlStream.removeEventListener(ProgressEvent.PROGRESS, onProgress);
      urlStream.removeEventListener(Event.COMPLETE,         onComplete);
      urlStream.removeEventListener(IOErrorEvent.IO_ERROR,  onIoError);
    }

    private function onOpen(event:Event):void
    {
      fileStream.open(UpdateStartScreen.getDownloadFile(), FileMode.WRITE);
    }

    private function onProgress(event:ProgressEvent):void
    {
      var loadedBytes:ByteArray = new ByteArray();
      urlStream.readBytes(loadedBytes);
      fileStream.writeBytes(loadedBytes);
    }

    private function onComplete(event:Event):void
    {
      status.setText("Download complete.");
      removeListeners();
      fileStream.close();
      urlStream.close();
      if (CONFIG::os === "osx")
      {
        app.Util.gotoScreen(self, UpdateDmgMountScreen);
      }
      else
      {
        app.Util.gotoScreen(
          self, 
          UpdateRunInstallerScreen, 
          UpdateStartScreen.getDownloadFile());
      }
    }

    private function onIoError(event:IOErrorEvent):void
    {
      removeListeners();
      fileStream.close();
      urlStream.close();
      status.setText("UpdateDownloadScreen: IO error: " + event.text);
    }
  }
}

