package 
{
  import flash.display.Sprite;
  import app.desktop.captive.UpdateStartScreen;

  public class MainDesktopCaptive extends Sprite
  {
    public function MainDesktopCaptive():void
    {
      addChild(new UpdateStartScreen());
    }
  }
}

