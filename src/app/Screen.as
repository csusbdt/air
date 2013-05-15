package app {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFieldAutoSize;

  /**
   *  The title screen is displayed after the updater runs.
   */
  public class Screen extends Sprite
  {
    protected static var textFormat:TextFormat = new TextFormat();

    protected static var status:TextField = new TextField();

    // static initialization
    {
      textFormat = new TextFormat();
      textFormat.font  = "Verdana";
      textFormat.color = 0x000000;
      textFormat.size  = 12;

      status.defaultTextFormat = textFormat;
      status.autoSize          = TextFieldAutoSize.LEFT;
      status.text              = "";
      status.x                 = 50;
      status.y                 = 50;
      status.multiline         = true;
      status.wordWrap          = true;
    }
  }
}

