package 
{
   import flash.display.Sprite;
   import app.TitleScreen;

   public class PlainMain extends Sprite
   {
      public function PlainMain() : void
      {
trace("Inside PlainMain constructor.");
        addChild(new TitleScreen());
      }
   }

}

