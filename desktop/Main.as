package 
{
  import flash.display.Sprite;
  import flash.display.NativeWindow;
  import app.desktop.air.UpdateStartScreen;

  public class Main extends Sprite
  {
    public function Main() : void
    {
      addChild(new UpdateStartScreen());
      stage.nativeWindow.activate();
    }
  }
}

