package app.update
{
  import flash.display.Sprite;
  import flash.filesystem.File;
  import flash.filesystem.FileStream;
  import flash.utils.setTimeout;
  import flash.utils.setTimeout;
  import app.StatusText;

  /**
   * This screen deletes any installer files that it finds in the application
   * storage directory.  The purpose is to clean up after an application update.
   * This should be the first screen to load when a program starts.
   */
  public class InstallerCleanupScreen extends Sprite
  {
    private var status:StatusText = new StatusText();
	private var fromScreen:Sprite;

    public function InstallerCleanupScreen():void
    {
      status.setText("Installer cleanup ...");
      addChild(status);
	  fromScreen = this;
	  setTimeout(init, 2000);
    }
	
    private function init():void
    {
      var file:File = InstallerDownloadScreen.getDownloadFile();
      if (file.exists) 
      { 
        try { file.deleteFile(); } catch (e:Error) { } 
      }
      app.Util.gotoScreen(fromScreen, VersionCheckScreen);
    }
  }
}

