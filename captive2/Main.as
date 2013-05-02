package {

   import flash.display.Sprite;
   import flash.text.TextField;

   public class Main extends Sprite
   {
      private var greeting:TextField = new TextField();

      public function Main() : void
      {
         greeting.text = CONFIG::message;
         greeting.x = 50;
         greeting.y = 50;
         addChild(greeting);
      }
   }

}

