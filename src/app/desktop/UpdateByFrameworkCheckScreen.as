package app.desktop
{
  import flash.display.Sprite;
  import flash.utils.setTimeout;
  import flash.events.ErrorEvent;
  import air.update.ApplicationUpdater;
  import air.update.events.StatusUpdateEvent;
  import app.TitleScreen;
  import app.StatusText;
  import app.Util;

  /**
   * TODO: comment
   */
  public class UpdateByFrameworkCheckScreen extends Sprite
  {
    private var self:UpdateByFrameworkCheckScreen;
    private var updater:ApplicationUpdater; 
    private var status:StatusText = new StatusText();

    public function UpdateByFrameworkCheckScreen(updater:ApplicationUpdater):void
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
      updater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, onStatus);
      updater.addEventListener(ErrorEvent.ERROR, onError);
    }

    private function removeListeners():void
    {
      updater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, onStatus);
      updater.addEventListener(ErrorEvent.ERROR, onError);
    }

    private function onStatus(event:StatusUpdateEvent):void
    {
      if (!event.available)
      {
        status.setText("Application is up to date.");
        removeListeners();
        app.Util.gotoScreen(self, TitleScreen);
      }
      else
      {
        status.setText("Installing new version.");
      }
    }

    private function onError(event:ErrorEvent):void
    {
      removeListeners();
      status.setText("Update error." + event.toString());
      app.Util.gotoScreen(self, TitleScreen);
    }
  }
}
