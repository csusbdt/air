package 
{
   import flash.display.Sprite;
   import app.UpdateScreen;

   /**
    * This is the application's main class, so and instance of it
    * is created at runtime and added as a child to the stage object.
    */
   public class Main extends Sprite
   {
      public function Main() : void
      {
        //nativeApplication = NativeApplication.nativeApplication;
        addChild(new UpdateScreen());
      }
   }

}

