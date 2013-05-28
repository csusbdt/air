package 
{
   import flash.display.Sprite;
   import app.desktop.UpdateByFrameworkInitializeScreen;

   public class MainDesktop extends Sprite
   {
      public function MainDesktop() : void
      {
        addChild(new UpdateByFrameworkInitializeScreen());
      }
   }

}

