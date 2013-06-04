package 
{
   import flash.display.Sprite;
   import app.TitleScreen;

   public class Android extends Sprite
   {
      public function Android() : void
      {
        addChild(new TitleScreen());
      }
   }
}

