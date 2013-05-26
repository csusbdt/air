package app.update
{
  import flash.display.Sprite;
  import flash.desktop.NativeApplication;
  import flash.desktop.NativeProcess;
  import flash.desktop.NativeProcessStartupInfo;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.NativeProcessExitEvent;
  import flash.filesystem.File;
  import flash.utils.setTimeout;
  
  import app.StatusText;

  public class RunInstallerScreen extends Sprite
  {
    private var installer:File;
    private var status:StatusText = new StatusText();
    private var process:NativeProcess = new NativeProcess();

    public function RunInstallerScreen(installer:File)
    {
	  this.installer = installer;
      status.setText("Running installer ...");
      addChild(status);
	  setTimeout(init, 2000);
    }
	
    private function init():void
    {
      addListeners();
      var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
      info.executable = installer;
      process.start(info);
    }
	
	private function addListeners():void
	{
      process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR,  onIOError);
      process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
      process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,    onOutput);
      process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA,     onDataError);
      process.addEventListener(NativeProcessExitEvent.EXIT,           onExit);
	}
	
	private function removeListeners():void
	{
      process.removeEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR,  onIOError);
      process.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
      process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,    onOutput);
      process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA,     onDataError);
      process.removeEventListener(NativeProcessExitEvent.EXIT,           onExit);
	}

    private function onOutput(event:ProgressEvent):void
    {
      process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable); 
    }
        
    private function onDataError(event:ProgressEvent):void
    {
      status.setText(event.toString());
      process.standardError.readUTFBytes(process.standardError.bytesAvailable); 
    }
        
    private function onExit(event:NativeProcessExitEvent):void
    {
	  removeListeners();
      setTimeout(NativeApplication.nativeApplication.exit, 1);
    }
        
    private function onIOError(event:IOErrorEvent):void
    {
      status.setText(event.toString());
	  removeListeners();
    }
  }
}

