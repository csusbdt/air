package app
{
  public class Util
  {
    public static function trim(s:String):String
    {
      return s.replace(/^\s+|\s+$/gs, "");
    }
  }
}

