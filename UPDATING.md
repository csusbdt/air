# Update Processes 

## Desktop Native Builds

There are 2 starting points for desktop native applications:
- MainNativeOsx
- MainNativeWin

To start the update process, the application transitions to the update screen.

__UpdateStartScreen__
  Deletes any existing installer.
  Retrieves the installer URL.
  If the installer URL is the same as the stored installer URL,
  there is nothing to do, so transition to the title screen.  
  Otherwise, transition to the download screen.

__UpdateDownloadScreen__
  Retrieve the file at installer URL.
  If we are in OS X, then transition to the mount DMG screen.
  Otherwise, transition to the run installer screen.

__UpdateDmgMountScreen__
  Mount the downloaded file.
  Transition to the run installer screen.

__UpdateRunInstallerScreen__
  Run the installer and exit.

## Desktop Pure AIR Builds

Only 1 starting point is needed for pure AIR desktop applications.

- MainDesktop

To start the update process, the application transitions to the update screen.

?


