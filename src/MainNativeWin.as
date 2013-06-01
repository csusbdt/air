package 
{
  import flash.display.Sprite;
  import app.desktop.native.UpdateStartScreen;

  public class MainNativeWin extends Sprite
  {
    public function MainNativeWin():void
    {
      addChild(new UpdateStartScreen());
    }
  }
}

