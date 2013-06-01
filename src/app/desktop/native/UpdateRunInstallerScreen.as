package app.desktop.native
{
  import flash.display.Sprite;
  import flash.desktop.NativeApplication;
  import flash.desktop.NativeProcess;
  import flash.desktop.NativeProcessStartupInfo;
  import flash.filesystem.File;
  import flash.utils.setTimeout;
  
  import app.StatusText;

  public class UpdateRunInstallerScreen extends Sprite
  {
    private var self:UpdateRunInstallerScreen;
    private var installer:File;
    private var status:StatusText = new StatusText();
    private var process:NativeProcess = new NativeProcess();

    public function UpdateRunInstallerScreen(installer:File)
    {
      this.installer = installer;
      status.setText("Running installer ...");
      addChild(status);
      setTimeout(run, 2000);
    }
	
    private function run():void
    {
      var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
      info.executable = installer;
      process.start(info);
      NativeApplication.nativeApplication.exit();
    }
  }
}

