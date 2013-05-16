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

  public class RunInstallerScreen extends Sprite
  {
    private var status:StatusText = new StatusText();

    private var installer:File = null;

    public function RunInstallerScreen(installer:File)
    {
      this.installer = installer;
      status.setText("Running installer ...");
      addChild(status);
      var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
      info.executable = installer;
      var process:NativeProcess = new NativeProcess();
      process.start(info);
      setTimeout(NativeApplication.nativeApplication.exit, 1000);
    }
  }
}

