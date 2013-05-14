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
  import app.Screen;

  public class RunInstallerScreen extends Screen
  {
    private var status:TextField = new TextField();

    private var installer:File = null;

    private function trim(s:String):String
    {
      return s.replace(/^\s+|\s+$/gs, "");
    }

    public function RunInstallerScreen(installer:File)
    {
      this.installer = installer;

      status.defaultTextFormat = textFormat;
      status.autoSize          = TextFieldAutoSize.LEFT;
      status.text              = "Running installer ...";
      status.x                 = 50;
      status.y                 = 50;
      status.multiline         = true;
      status.wordWrap          = true;
      addChild(status);

      var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
      info.executable = installer;
      var process:NativeProcess = new NativeProcess();
      process.start(info);
      setTimeout(NativeApplication.nativeApplication.exit, 1000);
    }
  }
}

