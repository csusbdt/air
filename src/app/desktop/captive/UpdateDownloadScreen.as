package app.desktop.captive
{
  import flash.display.Sprite;
  import flash.net.URLRequest;
  import flash.net.navigateToURL; 
  import flash.utils.setTimeout;
  import flash.desktop.NativeApplication;
  import app.StatusText;

  public class UpdateDownloadScreen extends Sprite
  {
    private var self:UpdateDownloadScreen;
    private var installerURL:String;
    private var status:StatusText     = new StatusText();

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
	  var urlReq:URLRequest = new URLRequest(installerURL); 
      navigateToURL(urlReq);
	  NativeApplication.nativeApplication.exit();
    }
  }
}

