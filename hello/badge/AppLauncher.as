package {

  import flash.display.*;
  import flash.events.*;
  import flash.geom.ColorTransform;
  import flash.net.URLRequest;
  import flash.system.*;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;

  public class AppLauncher extends Sprite
  {
    //private var airAppUrl:String = "http://localhost:5000/hello/hello.air";
    private var airAppUrl:String = CONFIG::airAppUrl;
    private var status:TextField = new TextField();
    private var air:Object;

    public function AppLauncher() 
    {
         status.text = "AppLauncher runs.";
         status.x = 10;
         status.y = 10;
         status.width = 300;
         addChild(status);

         var airLoader:Loader = new Loader();

         var myContext:LoaderContext = new LoaderContext();
         myContext.applicationDomain = ApplicationDomain.currentDomain;

         airLoader.load(new URLRequest("http://airdownload.adobe.com/air/browserapi/air.swf"), myContext);
         airLoader.contentLoaderInfo.addEventListener(Event.INIT, onInit);

/*
      var _loader:Loader = new Loader();
      try {
        _loader.load(new URLRequest(BROWSERAPI_URL_BASE + "/air.swf"), loaderContext);
      } catch (e:Error) {
//        root.statusMessage.text = e.message;
      }
*/
    }

    private function onInit(e:Event):void {
      air = e.target.content;
      switch (air.getStatus("3.7")) {
        case "available" :
          status.text = "can install AIR";
          break;
        case "unavailable" :
          status.text = "can not install AIR";
          break;
        case "installed" :
          status.text = "AIR present; Click to install hello app";
          addEventListener(MouseEvent.MOUSE_UP, installButtonClicked);
          break;
      }
    }

    private function installButtonClicked(e:Event):void {
      removeEventListener(MouseEvent.MOUSE_UP, installButtonClicked);
      status.text = "Installing hello app.";
      air.installApplication(airAppUrl, "3.7", ["launchFromBrowser"]);
    }
  }
}

