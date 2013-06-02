package app
{
  import flash.display.DisplayObject;
  import flash.utils.setTimeout;

  public class Util
  {
    public static function trim(s:String):String
    {
      return s.replace(/^\s+|\s+$/gs, "");
    }

    public static function gotoScreen(
      currentScreen:DisplayObject, 
      nextScreen:Class, 
      opt1 = null,
      opt2 = null):void
    {
      setTimeout(function():void {
        if (opt2) {
          currentScreen.parent.addChild(DisplayObject(new nextScreen(opt1, opt2)));
        } else if (opt1) {
          currentScreen.parent.addChild(DisplayObject(new nextScreen(opt1)));
        } else {
          currentScreen.parent.addChild(DisplayObject(new nextScreen()));
        }
        currentScreen.parent.removeChild(currentScreen);
      }, 2000);
    }
  }
}

