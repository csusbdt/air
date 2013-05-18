package app {

   import flash.display.Sprite;

   /**
    *  The title screen is displayed after the updater runs.
    */
   public class TitleScreen extends Sprite
   {
      public function TitleScreen()
      {
         addChild(new StatusText("Title Screen"));
      }
   }

}

