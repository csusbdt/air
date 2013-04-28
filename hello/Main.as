package {

   import flash.display.Sprite;
   import flash.text.TextField;

   public class Main extends Sprite
   {
      private var greeting:TextField = new TextField();

      public function Main() : void
      {
         greeting.text = "Hello, AIR!";
         greeting.x = 100;
         greeting.y = 100;
         addChild(greeting);
         trace(CONFIG::message);
      }
   }

}

