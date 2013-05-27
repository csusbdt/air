package app.desktop
{
  import flash.display.Sprite;
  import flash.utils.setTimeout;
  import flash.events.ErrorEvent;
  import air.update.ApplicationUpdaterUI;
  import air.update.events.UpdateEvent;
//  import air.update.events.StatusUpdateErrorEvent;
//  import air.update.events.DownloadErrorEvent;
  import app.TitleScreen;
  import app.StatusText;
  import app.Util;

  /**
   * TODO: comment
   */
  public class UpdateByFrameworkScreen extends Sprite
  {
    private var self:UpdateByFrameworkScreen;
    private var status:StatusText = new StatusText();
    private var updater:ApplicationUpdaterUI = new ApplicationUpdaterUI(); 

    public function UpdateByFrameworkScreen():void
    {
      self = this;
      status.setText("Updating.");
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
//      updater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, onError);
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
