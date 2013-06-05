package 
{
  import flash.display.Sprite;
  import flash.display.NativeWindow;
  import app.desktop.captive.UpdateStartScreen;

  public class Main extends Sprite
  {
    public function Main():void
    {
      addChild(new UpdateStartScreen("osx"));
      stage.nativeWindow.activate();
    }
  }
}

