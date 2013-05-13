package 
{
   import flash.display.Sprite;
   import app.VersionCheckScreen;

   public class OsxMain extends Sprite
   {
      public function OsxMain() : void
      {
trace("Inside OsxMain constructor.");
         addChild(new VersionCheckScreen());
      }
   }

}

