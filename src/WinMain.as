package 
{
   import flash.display.Sprite;
   import app.update.VersionCheckScreen;

   public class WinMain extends Sprite
   {
      public function WinMain() : void
      {
        addChild(new VersionCheckScreen());
      }
   }

}

