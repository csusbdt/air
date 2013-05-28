package app.desktop
{
  import flash.display.Sprite;
  import flash.utils.setTimeout;
  import flash.events.ErrorEvent;
  import air.update.ApplicationUpdaterUI;
  import air.update.events.UpdateEvent;
  import app.TitleScreen;
  import app.StatusText;
  import app.Util;

  /**
   * TODO: comment
   */
  public class UpdateByFrameworkCheckScreen extends Sprite
  {
    private var self:UpdateByFrameworkCheckScreen;
    private var updater:ApplicationUpdaterUI; 
    private var status:StatusText = new StatusText();

    public function UpdateByFrameworkCheckScreen(updater:ApplicationUpdaterUI):void
    {
      self = this;
      this.updater = updater;
      status.setText("Checking for updates.");
      addChild(status);
      setTimeout(init, 2000);
    }

    private function init():void
    {
      addListeners();
      updater.checkNow();
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
      app.Util.gotoScreen(self, TitleScreen);
    }

    private function onError(event:ErrorEvent):void
    {
      removeListeners();
      status.setText("Initialization error." + event.toString());
    }
  }
}
