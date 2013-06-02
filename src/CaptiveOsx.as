package 
{
  import flash.display.Sprite;
  import app.desktop.captive.UpdateStartScreen;

  public class CaptiveOsx extends Sprite
  {
    public function CaptiveOsx():void
    {
      addChild(new UpdateStartScreen("osx"));
    }
  }
}

