package {

   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;

   /**
    * This is the application's main class, so and instance of it
    * is created at runtime and added as a child to the stage object.
    */
   public class Main extends Sprite
   {
      public function Main() : void
      {
         var format:TextFormat = new TextFormat();
         format.font  = "Verdana";
         format.color = 0x000000;
         format.size  = 12;

         var greeting:TextField = new TextField();
         greeting.defaultTextFormat = format;
         greeting.autoSize          = TextFieldAutoSize.LEFT;
         greeting.text              = CONFIG::message;
         greeting.x                 = 50;
         greeting.y                 = 50;

         addChild(greeting);
      }
   }

}

