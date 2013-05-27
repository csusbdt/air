package 
{
  import flash.display.Sprite;
  import app.desktop.native.UpdateStartScreen;

  public class MainNativeOsx extends Sprite
  {
    public function MainNativeOsx():void
    {
      addChild(new UpdateStartScreen());
    }
  }
}

