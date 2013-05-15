package app {

   import flash.display.Sprite;

   /**
    *  The title screen is displayed after the updater runs.
    */
   public class TitleScreen extends Screen
   {
      public function TitleScreen()
      {
         status.text = "Title Screen";
         addChild(status);
trace("title screen status added");
      }
   }

}

