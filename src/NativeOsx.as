package 
{
  import flash.display.Sprite;
  import app.desktop.native.UpdateStartScreen;

  public class NativeOsx extends Sprite
  {
    public function NativeOsx():void
    {
      addChild(new UpdateStartScreen("osx"));
    }
  }
}

