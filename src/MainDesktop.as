package 
{
   import flash.display.Sprite;
   import app.desktop.UpdateByFrameworkScreen;

   public class MainDesktop extends Sprite
   {
      public function MainDesktop() : void
      {
        addChild(new UpdateByFrameworkScreen());
      }
   }

}

