package app {

  import flash.display.Sprite;
  import flash.text.TextFormat;

  /**
   *  The title screen is displayed after the updater runs.
   */
  public class Screen extends Sprite
  {
     protected static var textFormat:TextFormat = new TextFormat();

     // static initialization
     {
        textFormat = new TextFormat();
        textFormat.font  = "Verdana";
        textFormat.color = 0x000000;
        textFormat.size  = 12;
     }
  }
}

