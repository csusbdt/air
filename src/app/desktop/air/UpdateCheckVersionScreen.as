package app.desktop.air
{
  import flash.display.Sprite;
  import flash.utils.setTimeout;
  import flash.events.ErrorEvent;
  import air.update.ApplicationUpdater;
  import air.update.events.StatusUpdateEvent;
  import air.update.events.StatusUpdateErrorEvent;
  import app.TitleScreen;
  import app.StatusText;
  import app.Util;

  /**
   * TODO: comment
   */
  public class UpdateCheckVersionScreen extends Sprite
  {
    private var self:UpdateCheckVersionScreen;
    private var updater:ApplicationUpdater; 
    private var status:StatusText = new StatusText();

    public function UpdateCheckVersionScreen(updater:ApplicationUpdater):void
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
      updater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, onStatusUpdateError);
      updater.addEventListener(ErrorEvent.ERROR, onError);
    }

    private function removeListeners():void
    {
      updater.removeEventListener(StatusUpdateEvent.UPDATE_STATUS, onStatus);
      updater.removeEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, onStatusUpdateError);
      updater.removeEventListener(ErrorEvent.ERROR, onError);
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

    private function onStatusUpdateError(event:StatusUpdateErrorEvent):void
    {
      removeListeners();
      status.setText("Status update error." + event.toString());
      app.Util.gotoScreen(self, TitleScreen);
    }

    private function onError(event:ErrorEvent):void
    {
      removeListeners();
      status.setText("Update error." + event.toString());
      app.Util.gotoScreen(self, TitleScreen);
    }
  }
}
