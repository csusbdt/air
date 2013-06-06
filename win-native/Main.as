package 
{
  import flash.display.Sprite;
  import flash.display.NativeWindow;
  import app.desktop.native.UpdateStartScreen;

  public class Main extends Sprite
  {
    public function Main():void
    {
      addChild(new UpdateStartScreen("win"));
      stage.nativeWindow.activate();
    }
  }
}

