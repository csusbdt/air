# Hello Adobe AIR

See the following for info regarding StageWebView, which I believe is needed by facebook library.

http://help.adobe.com/en_US/air/build/WSfffb011ac560372f-5d0f4f25128cc9cd0cb-7ffc.html#WS365a66ad37c9f5102ec8a8ba12f2d91095a-8000

## Setup

After cloning this repo, you need to do the following set up.

- Create file props.properties with the following property definitions. (Use your own values.)

    appId=csusbdt.hello.air
    appName=Hello AIR
    versionNumber=1.0.0
    appFilename=hello-air
    installerSite=http://localhost:5000

- Install Nodejs. (Get from website.)
- Install the Nodejs connect module with the npm command.

    npm install connect

- Download AIR SDK and unpack in a convenient location.  
I unpacked the sdk to _$HOME/apps/AIRSDK_Compiler_.

- Set environmental variables.  On mac, I added the following to _.bash_profile_.

    export AIR_SDK_HOME=$HOME/apps/AIRSDK_Compiler
    export PATH=$PATH:$AIR_SDK_HOME/bin
    export PATH=$PATH:$AIR_SDK_HOME/lib/android/bin

## Sub-project Notes

This project is divided into several sub-projects, one for each type of installation.
The sub-projects refer to a common code base; however, some Action Script files are
specifically for sub-projects.  Each Sub-project has its own entry point, stored in
Main.as in the sub-project folder.
These sub-projects are separated into folders, and are described as follows.

### desktop

The desktop sub-project builds the common app code for distribution in the air file format.

Currently, the desktop project only builds under OS X.  However, it runs in OS X and Windows and
the build script can easily be changed to build the air file in Windows.

The solution presented here does not use the installation badge system provided by
Adobe, because that system is broken for the Chrome web browser.  This means the user needs to
install the air runtime as a separate initial step.   One thing that could be done is to
modify the installation badge code to detect if the runtime is present and if not to 
tell the user to install it.  I did not do this because the native installation processes
for Windows and OS X illustrated in this project provide an easier experience for the user.

### osx-native/win-native

The osx-native and win native sub-projects build the common app code for distribution using 
Adobe's native installer approach.  In my experience, this approach is the easiest. 

This approach is the most completely worked out example in this example application project.  

Unlike the pure air approach illustrated in the desktop folder, the native installation 
approach supports native extensions (untested here).  TODO: test native extension.

### osx-captive/win-captive

The osx-captive and win-captive sub-projects build the common app code for distribution 
to OS X and Windows desktop environments with a captive runtime. This means the Action Script 
runtime is built into the app and therefore does not depend on Adobe AIR being installed 
on the user system.
 
The example presented here shows how to generate the executable with captive runtime; 
it does not show how to construct an installer.  However, the example does illustrate 
how the application can detect the existence of updates and how to open a browser instance 
from code download the update automatically without user effort.  TODO: ask the user
if they want to download the update rather than download without asking.

### ios

The ios sub-project builds the common app code for distribution to iOS environments 
with a captive runtime. This is the only way to distribute Adobe AIR programs to the
iOS environment.  TODO: test using application developer account.

Unlike captive builds for the desktop, the captive build for iOS does not include
webkit, so HTML can not be used in the app.  The documentation says the overhead of 
the captive runtime is 9 MB (unverified).  TODO: verify this.

### droid

The droid sub-project builds the common app code for distribution to Android environments 
with a captive runtime. This is the default way to distribute Adobe AIR programs to the
Android environment when using AIR SDK 3.7.

Similar to the iOS sub-project, the captive build for Android does not include
webkit, so HTML can not be used in the app.

### Build scripts

Each sub-project has a file named _build.xml_, which controls the build process for
the sub-project.  These build files contain the following common targets.

- __compile__ Build _temp/Main.swf_.
- __app__ Build _temp/application.xml_.
- __package__ Build the various downloadables (*.air, *.exe, *.dmg, *.zip).
- __web__ Prepare the web server to test the update function.


## How to Uninstall AIR

- http://www.kevinblanchard.com/projects/uninstalling-adobe-air-on-os-x/
- http://flash-gallery.com/help/faq/uninstall-adobe-air/

## Project status

- [Packaging a captive runtime bundle for desktop computers](http://help.adobe.com/en_US/air/build/WSfffb011ac560372f709e16db131e43659b9-8000.html).

For iOS, consider this WARNING: See [which AIR SDK versions will run which iOS versions](http://stackoverflow.com/questions/16243485/which-air-sdk-versions-will-run-which-ios-versions).

I will look at the following:

- Starling
- Feathers
- DragonBones
- http://citrusengine.com/
- [ANE-Push-Notification](https://github.com/freshplanet/ANE-Push-Notification)

## Overview

This project illustrates one way to setup an application development
project that uses a common code base written in Action Script and
runnable in both desktop and mobile computers by utilizing the Adobe AIR
runtime.  All build operations are performed using Ant.

### Adobe AIR Installation badge

The Adobe AIR Installation badge (runs in Flash plugin) has not worked in Chrome for over a year; 
see the footnotes in the criticism section in 
[Adobe Integrated Runtime](http://en.wikipedia.org/wiki/Adobe_Integrated_Runtime).
Also, the installation badge does not support installation of applications that include
native extensions.
For these reasons, this project will not use the installation badge.

### Captive AIR runtime

From [Adobe's roadmap whitepaper](http://www.adobe.com/devnet/flashplatform/whitepapers/roadmap.html):

> Adobe AIR 3 added the ability to package and distribute a captive AIR runtime 
> with the AIR distributable file. 
> This allows the application to run independent of any version of Adobe AIR 
> that may be installed on the system. 
> __Adobe recommends that all AIR content be distributed using a captive runtime,__ 
> and not rely on an AIR runtime being installed in order for the application to run.

NOTE: Captive AIR runtime distribution is required for iOS because iOS does
not support the shared runtime model needed otherwise; see 
[Installation and deployment options in Adobe AIR 3](http://www.adobe.com/devnet/air/articles/air3-install-and-deployment-options.html).

NOTE 2: Captive AIR runtime is now required for Android.
See [Adobe AIR Android applications move to Captive Runtime](http://blogs.adobe.com/airodynamics/2013/03/11/android-shared-runtime-drop-support/).

CONCLUSION: build targets for iOS and Android in this sample project will use captive runtime.

### Update framework for desktop deployment

If the application does not reply on native code or on extended desktop functionality
(such as accessing the file system or using a native extension), then we can use 
the Adobe AIR update framework.

This project will try to illustrate a desktop update process for both pure AIR applications
and applications with native functionality that need native installers.

## References

- [Adobe AIR](http://help.adobe.com/en_US/air/build/index.html)
- [Using the update framework](http://help.adobe.com/en_US/air/build/WS9CD40F06-4DD7-4230-B56A-88AA27541A1E.html)
- [Installation logs on desktop computers](http://help.adobe.com/en_US/air/build/WS5b3ccc516d4fbf351e63e3d118666ade46-7fcb.html#WS60df0f297466d593625374fb1262e2ef77b-8000)
- [Actionscript 3](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/)
- [Updating Adobe AIR applications packaged with a native installer](http://www.adobe.com/devnet/air/articles/updating-air-apps-native-installer.html)
- [Adobe Flash Platform](http://help.adobe.com/en_US/as3/dev/index.html)
- [Programming Adobe ActionScript 3.0 for Adobe Flash](http://help.adobe.com/en_US/ActionScript/3.0_ProgrammingAS3)
- [Installation and deployment options in Adobe AIR 3](http://www.adobe.com/devnet/air/articles/air3-install-and-deployment-options.html)
- [Blog note on reducing file size](http://www.shedosurashu.com/captive-runtime-not-what-i-thought-it-to-be)
- [Relationship of Adobe AIR SDK and Flex SDK?](http://stackoverflow.com/questions/12554447/relationship-of-adobe-air-sdk-and-flex-sdk)
- [Clarify usage of playerglobal.swc and airglobal.swc](https://issues.apache.org/jira/browse/FLEX-33089)

## Prerequisites

- Install Apache Ant.
- Install the AIR SDK. (Download and unpack somewhere.)

After unpacking the AIR SDK, set environmental variable AIR_SDK_HOME 
to its location and ad its bin folder to the system path.  On my system,
I added the following to _.bash_profile_

    export AIR_SDK_HOME=$HOME/apps/AIRSDK_Compiler
    export PATH=$PATH:$AIR_SDK_HOME/bin
    export PATH=$PATH:$AIR_SDK_HOME/lib/android/bin

## Testing on Android

You need to enable applications to run from unknown sources.
Under Androind 4.0, go to Settings ...Security ... Unknown Sources, 
and then _allow installation of apps other than the Play Store_.

You need to enable USB debugging.
Under Android 4.0, go to Settings ... Developer Options ... 
Debugging, and check _Debugging mode launches when USB is connected.

Connect the device to the desktop computer with a USB cable.
Android indicates that the USB device is connected as a media device.

## Troubleshooting

### _application descriptor not found_

If you get _application descriptor not found_ from running _adl_ (or other similar tool),
then the application XML may be invalid.

### Debugging installed applications

__This had very limited benefit for me.__  Maybe I didn't set it up correctly.

To enable better reporting of problems and maybe
to get a terminal window at runtime for applications
installed in OSX, create an empty
file called _debug_ under the _META-INF/AIR_ folder
in the installed application.  On my system, I did the following.

    touch /Applications/HelloDesktopAIR.app/Contents/Resources/META-INF/AIR/debug

### Changing Certificates

If you install an app with a certificate and then try to reinstall the app under a different
certificate, the installation will fail.  I believe that when the user installs Adobe AIR,
it scans the entore system for .air files, and when it finds then, makes a record of the
certificate used to install them.  In my case, the AIR installer searched my trash and
found deleted .air files.  These deleted files were installed with a different certificate,
so AIR refused to install the app after I regenerated the certificate.  After I emptied my
trash and reinstalled AIR, I was able to install the app.

To help discover this problem, I looked at the following log file,
which recorded logs written by AIR showing that it discovered .air files in the trash.

    /private/var/log/system.log

The tail command is convenient for looking at what is being written into log files.

    tail -f /private/var/log/system.log

See [Logging for Adobe AIR 2 Desktop application and runtime installations](http://helpx.adobe.com/air/kb/logging-air-2-desktop-application.html).

### Checking cleanup of installer

To see that the installer files are deleted after use, 
I looked in the following location.

    ls "/Users/turner/Library/Application Support/com.herokuapp.csusbdt-air.desktop/Local Store/"



