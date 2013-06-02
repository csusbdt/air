package 
{
  import flash.display.Sprite;
  import app.desktop.native.UpdateStartScreen;

  public class NativeWin extends Sprite
  {
    public function NativeWin():void
    {
      addChild(new UpdateStartScreen("win"));
    }
  }
}

