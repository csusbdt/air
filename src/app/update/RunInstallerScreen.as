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
  import flash.events.NativeProcessExitEvent;
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


  public class RunInstallerScreen extends Sprite
  {
    private var status:StatusText = new StatusText();

//    private var installer:File = null;
    private var process:NativeProcess = new NativeProcess();

    public function RunInstallerScreen(installer:File)
    {
  //    setTimeout(NativeApplication.nativeApplication.exit, 1);
  //    this.installer = installer;
      //status.setText("Running installer ...");
      status.setText("Running " + installer.nativePath);
trace("Running " + installer.nativePath);
      addChild(status);
      var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
      info.executable = installer;
      process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR,  handleIOError);
      process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, handleIOError);
      process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,    handleOutput);
      process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA,     handleDataError);
      process.addEventListener(NativeProcessExitEvent.EXIT,           handleExit);
      process.start(info);
    }

    public function handleOutput(event:ProgressEvent):void
    {
        trace("Got: ", process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable)); 
    }
        
    public function handleDataError(event:ProgressEvent):void
    {
        trace("ERROR -", process.standardError.readUTFBytes(process.standardError.bytesAvailable)); 
    }
        
    public function handleExit(event:NativeProcessExitEvent):void
    {
        trace("Process exited with ", event.exitCode);
      setTimeout(NativeApplication.nativeApplication.exit, 1);
    }
        
    public function handleIOError(event:IOErrorEvent):void
    {
        trace(event.toString());
    }
  }
}

