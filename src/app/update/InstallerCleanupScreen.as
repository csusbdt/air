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

  import flash.utils.setTimeout;
  import app.StatusText;

  /**
   * This screen deletes any installer files that it finds in the application
   * storage directory.  The purpose is to clean up after an application update.
   */
  public class InstallerCleanupScreen extends Sprite
  {
    private var status:StatusText = new StatusText();

    public function InstallerCleanupScreen():void
    {
      status.setText("Installer cleanup ...");
      addChild(status);
      var list:Array = File.applicationStorageDirectory.getDirectoryListing();
      for (var i:uint = 0; i < list.length; i++) {
        if (list[i].nativePath.search(".dmg") > -1 || list[i].nativePath.search(".msi") > -1)
        {
          list[i].deleteFile();
        }
      }
      var self:Sprite = this;
      setTimeout(function():void {
        parent.addChild(new VersionCheckScreen());
        parent.removeChild(self);
      }, 2000);
    }
  }
}

