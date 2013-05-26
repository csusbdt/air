package app.update
{
  import flash.display.Sprite;
  import flash.desktop.NativeApplication;
  import flash.desktop.NativeProcess;
  import flash.desktop.NativeProcessStartupInfo;
  import flash.events.NativeProcessExitEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  import flash.utils.ByteArray;
  import flash.utils.setTimeout;
  import app.StatusText;

  public class MountOsxInstallerScreen extends Sprite
  {
    private var nativeProcess  : NativeProcess;
    public  var mountPoint     : String;
    private var status         : StatusText = new StatusText();

    public function MountOsxInstallerScreen()
    {
      status.setText("Mounting dmg file.");
      addChild(status);
      setTimeout(init, 2000);
    }
	
	private function init():void
	{
      var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
      info.executable = new File("/usr/bin/hdiutil");
                        
      var args:Vector.<String> = new Vector.<String>();
      args.push("attach", "-plist", InstallerDownloadScreen.getDownloadFile().nativePath);
      info.arguments = args;
                        
      nativeProcess = new NativeProcess();
      nativeProcess.start(info);
	}

    private function addListeners():void
    {
      nativeProcess.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR,  onError);
      nativeProcess.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onError);
      nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,    onOutputData);
      nativeProcess.addEventListener(NativeProcessExitEvent.EXIT,           onExit);
    }

    private function removeListeners():void
    {
      nativeProcess.removeEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR,  onError);
      nativeProcess.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onError);
      nativeProcess.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,    onOutputData);
      nativeProcess.removeEventListener(NativeProcessExitEvent.EXIT,           onExit);
    }

	private function onExit(event:NativeProcessExitEvent):void
    {
	  // I want to move logic here and ignore output data event.
	  // See https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/hdiutil.1.html
      trace("Process exited with ", event.exitCode);
    }
		
    private function onOutputData(event:ProgressEvent):void
    {
      nativeProcess.exit();
      removeListeners();
                        
      var originalXmlSettings:Object = XML.settings();
      // Required settings for custom XML settings
      XML.setSettings({
        ignoreWhitespace : true,
        ignoreProcessingInstructions : true,
        ignoreComments : true,
        prettyPrinting : false
      });
                                
      var plist:XML = new XML(nativeProcess.standardOutput.readUTFBytes(event.bytesLoaded));
      var dicts:XMLList = plist.dict.array.dict;

      for each(var dict:XML in dicts)
      {
        for each(var element:XML in dict.elements())
        {
          if (element.name() == "key" && element.text() == "mount-point")
          {
             mountPoint = dict.child(element.childIndex() + 1);
             break;
          }
        }
      }

      XML.setSettings(originalXmlSettings);
                        
      if (mountPoint)
      {
        var attachedDmg:File = new File(mountPoint);
        var files:Array = attachedDmg.getDirectoryListing();    
        if (files.length != 1)
        {
          status.setText("Mounted volume should contain only 1 install file!");
          return;
        }
        var installFileFolder:File = File(files[0]).resolvePath("Contents/MacOS");
        var installFiles:Array = installFileFolder.getDirectoryListing();

        if (installFiles.length == 1)
        {
          app.Util.gotoScreen(this, RunInstallerScreen, installFiles[0]);
        }
        else
        {
          status.setText("Contents/MacOS folder should contain only 1 install file!");
        }
      }
      else
      {
        status.setText("Couldn't find mount point!");
      }
    }

    private function onError(event:IOErrorEvent):void
    {
      status.setText(event.text);
    }
  }
}

