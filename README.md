# Hello Adobe AIR

This project illustrates one way to setup an application development
project that uses a common code base written in Action Script and
runnable in both desktop and mobile computers by utilizing the Adobe AIR
runtime.  All build operations are performed using Ant.

This project currently supports OS X only.

## Captive AIR runtime

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

ALSO NOTE: AIR installation through Chrome has not worked for over a year; see the footnotes
in the criticism section in 
[Adobe Integrated Runtime](http://en.wikipedia.org/wiki/Adobe_Integrated_Runtime).

CONCLUSION: This project will use captive AIR runtime packaging.

WARNING: See [which AIR SDK versions will run which iOS versions](http://stackoverflow.com/questions/16243485/which-air-sdk-versions-will-run-which-ios-versions).

## Troubleshooting

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

## Reading

- [Updating Adobe AIR applications packaged with a native installer](http://www.adobe.com/devnet/air/articles/updating-air-apps-native-installer.html)
- [Adobe Flash Platform](http://help.adobe.com/en_US/as3/dev/index.html)
- [Programming Adobe ActionScript 3.0 for Adobe Flash](http://help.adobe.com/en_US/ActionScript/3.0_ProgrammingAS3)
- [Installation and deployment options in Adobe AIR 3](http://www.adobe.com/devnet/air/articles/air3-install-and-deployment-options.html)
- [Blog note on reducing file size](http://www.shedosurashu.com/captive-runtime-not-what-i-thought-it-to-be)
- [Relationship of Adobe AIR SDK and Flex SDK?](http://stackoverflow.com/questions/12554447/relationship-of-adobe-air-sdk-and-flex-sdk)
- [Clarify usage of playerglobal.swc and airglobal.swc](https://issues.apache.org/jira/browse/FLEX-33089)

## Application update

- [READ ME NEXT](http://www.adobe.com/devnet/air/articles/updating-air-apps-native-installer.html)
- [Beyond Plain Old HTML Objects NativeApplicationUpdater – updater for AIR apps packaged with native installers](http://www.riaspace.com/2010/08/nativeapplicationupdater-updater-for-air-apps-packaged-with-native-installers/)


## Research

- Starling
- Feathers
- http://citrusengine.com/


