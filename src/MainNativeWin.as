package 
{
  import flash.display.Sprite;
  import app.desktop.native.UpdateStartScreen;
//  import app.TitleScreen;

  public class MainNativeWin extends Sprite
  {
    public function MainNativeWin():void
    {
      addChild(new UpdateStartScreen());
//      addChild(new TitleScreen());
    }
  }
}

