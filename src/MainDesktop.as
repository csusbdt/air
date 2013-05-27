package 
{
   import flash.display.Sprite;
   import app.TitleScreen;

   public class MainDesktop extends Sprite
   {
      public function MainDesktop() : void
      {
        addChild(new TitleScreen());
      }
   }

}

