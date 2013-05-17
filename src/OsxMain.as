package 
{
   import flash.display.Sprite;
   import app.update.VersionCheckScreen;

   public class OsxMain extends Sprite
   {
      public function OsxMain() : void
      {
         addChild(new VersionCheckScreen());
      }
   }

}

