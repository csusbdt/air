package app.desktop
{
  import flash.display.Sprite;
  import flash.utils.setTimeout;
  import flash.events.ErrorEvent;
  import air.update.ApplicationUpdater;
  import air.update.events.UpdateEvent;
  import app.TitleScreen;
  import app.StatusText;
  import app.Util;

  /**
   * TODO: comment
   */
  public class UpdateByFrameworkInitializeScreen extends Sprite
  {
    private var self:UpdateByFrameworkInitializeScreen;
    private var status:StatusText = new StatusText();
    private var updater:ApplicationUpdater = new ApplicationUpdater(); 

    public function UpdateByFrameworkInitializeScreen():void
    {
      self = this;
      status.setText("Initializing update system.");
      addChild(status);
      setTimeout(init, 2000);
    }

    private function init():void
    {
      addListeners();
      updater.updateURL = CONFIG::installerSite + "/hello-air.xml"; 
      updater.initialize();
    }

    private function addListeners():void
    {
      updater.addEventListener(UpdateEvent.INITIALIZED, onInitialized);
      updater.addEventListener(ErrorEvent.ERROR, onError);
    }

    private function removeListeners():void
    {
      updater.addEventListener(UpdateEvent.INITIALIZED, onInitialized);
      updater.addEventListener(ErrorEvent.ERROR, onError);
    }

    private function onInitialized(event:UpdateEvent):void
    {
      status.setText("Initialized.");
      removeListeners();
      app.Util.gotoScreen(self, UpdateByFrameworkCheckScreen, updater);
    }

    private function onError(event:ErrorEvent):void
    {
      removeListeners();
      status.setText("Initialization error." + event.toString());
      app.Util.gotoScreen(self, TitleScreen);
    }
  }
}
