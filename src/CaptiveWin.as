package 
{
  import flash.display.Sprite;
  import app.desktop.captive.UpdateStartScreen;

  public class CaptiveWin extends Sprite
  {
    public function CaptiveWin():void
    {
      addChild(new UpdateStartScreen("win"));
    }
  }
}

