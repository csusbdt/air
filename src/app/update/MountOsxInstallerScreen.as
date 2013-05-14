package app.update
{
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;

  import flash.desktop.NativeApplication;
  import flash.desktop.NativeProcess;
  import flash.desktop.NativeProcessStartupInfo;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  import flash.system.Capabilities;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLStream;
  import flash.utils.setTimeout;
  import flash.utils.ByteArray;
  import app.Screen;

  public class MountOsxInstallerScreen extends Screen
  {
    private var dmg            :File;
    private var nativeProcess  :NativeProcess;
    public  var mountPoint     :String;

    public function MountOsxInstallerScreen(dmg:File)
    {
      this.dmg = dmg;
      status.text = "Mounting osx installer.";
      addChild(status);

      var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
      info.executable = new File("/usr/bin/hdiutil");
                        
      var args:Vector.<String> = new Vector.<String>();
      args.push("attach", "-plist", dmg.nativePath);
      info.arguments = args;
                        
      nativeProcess = new NativeProcess();
      nativeProcess.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR,  handleError);
      nativeProcess.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, handleError);
      nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,    handleOutputData);
      nativeProcess.start(info);
    }

    private function removeListeners():void
    {
      nativeProcess.removeEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR,  handleError);
      nativeProcess.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, handleError);
      nativeProcess.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,    handleOutputData);
    }

    private function handleOutputData(event:ProgressEvent):void
    {
      removeListeners();
      nativeProcess.exit();
                        
      var originalXmlSettings:Object = XML.settings();
      // Required settings for custom XML settings
      XML.setSettings({
        ignoreWhitespace : true,
        ignoreProcessingInstructions : true,
        ignoreComments : true,
        prettyPrinting : false
      });
                                
      var plist:XML = new XML(hdiutilProcess.standardOutput.readUTFBytes(event.bytesLoaded));
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
          status.text = "Mounted volume should contain only 1 install file!";
          return;
        }
        var installFileFolder:File = File(files[0]).resolvePath("Contents/MacOS");
        var installFiles:Array = installFileFolder.getDirectoryListing();

        if (installFiles.length == 1)
        {
          parent.addChild(new RunInstallerScreen(installFiles[0]));
          removeChild(status);
          parent.removeChild(this);
        }
        else
        {
          status.text = "Contents/MacOS folder should contain only 1 install file!";
        }

      }
      else
      {
        status.text = "Couldn't find mount point!";
      }
    }

    private function handleError(event:IOErrorEvent):void
    {
      status.text = event.text;
    }

  }
}

