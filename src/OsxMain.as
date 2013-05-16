package 
{
   import flash.display.Sprite;
   import app.update.VersionCheckScreen;
   import app.TitleScreen;

   public class OsxMain extends Sprite
   {
      public function OsxMain() : void
      {
trace("Inside OsxMain constructor.");
         addChild(new VersionCheckScreen());
      }
   }

}

