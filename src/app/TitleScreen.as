package app {

   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;

   /**
    *  The title screen is displayed after the updater runs.
    */
   public class TitleScreen extends Screen
   {
      private var greeting:TextField = new TextField();

      public function TitleScreen()
      {
         greeting.defaultTextFormat = textFormat;
         greeting.autoSize          = TextFieldAutoSize.LEFT;
         greeting.text              = "Title Screen";
         greeting.x                 = 50;
         greeting.y                 = 50;
         addChild(greeting);
      }
   }

}

