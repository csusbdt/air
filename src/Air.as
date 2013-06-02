package 
{
   import flash.display.Sprite;
   import app.desktop.air.UpdateStartScreen;

   public class Air extends Sprite
   {
      public function Air() : void
      {
        addChild(new UpdateStartScreen());
      }
   }
}

