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

    public static function gotoScreen(currentScreen:DisplayObject, nextScreen:Class, optionalArgument = null):void
    {
      setTimeout(function():void {
        if (optionalArgument) {
          currentScreen.parent.addChild(DisplayObject(new nextScreen(optionalArgument)));
        } else {
          currentScreen.parent.addChild(DisplayObject(new nextScreen()));
        }
        currentScreen.parent.removeChild(currentScreen);
     }, 2000);
    }
  }
}

