# Notes on Adobe Air

The purpose of this repository is to keep a record of my research and experimentation
on developing applications that run in Adobe AIR.

The _hello_ project is currently under construction (75% complete).

I am in the process of converting scripts to ant build files.

## Captive AIR runtime

From [Adobe's roadmap whitepaper](http://www.adobe.com/devnet/flashplatform/whitepapers/roadmap.html):

> Adobe AIR 3 added the ability to package and distribute a captive AIR runtime 
> with the AIR distributable file. 
> This allows the application to run independent of any version of Adobe AIR 
> that may be installed on the system. 
> __Adobe recommends that all AIR content be distributed using a captive runtime,__ 
> and not rely on an AIR runtime being installed in order for the application to run.

Also, use of captive AIR runtime is the only way to get an AIR application to run on iOS.

For these reasons, I will focus on developing instructions for set up of a project
that uses captive AIR runtime packaging.

## References

- [Adobe AIR](http://help.adobe.com/en_US/air/build/index.html)

