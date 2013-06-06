package app {

  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFieldAutoSize;

  /**
   *  Class for displaying status messages.
   */
  public class StatusText extends TextField
  {
    private static var textFormat:TextFormat = new TextFormat();

    {
      textFormat.font  = "Verdana";
      textFormat.color = 0x000000;
      textFormat.size  = 24;
    }

    public function StatusText(text:String = "")
    {
      x                 = 50;
      y                 = 50;
      width             = 360;
      height            = 560;
      autoSize          = TextFieldAutoSize.LEFT;
      this.text         = text; 
      multiline         = true;
      wordWrap          = true;
      setTextFormat(textFormat);      
    }

    public function setText(text:String):void
    {
      this.text = text;
      setTextFormat(textFormat);      
    }
  }
}

