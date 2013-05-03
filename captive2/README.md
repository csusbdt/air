# Captive AIR Runtime Experiment

These are the beginnings of my notes on setting up a project
that relies on captive runtime distribution.

Captive AIR runtime distribution is required for iOS because iOS does
not support the shared runtime model needed otherwise; see 
[Installation and deployment options in Adobe AIR 3](http://www.adobe.com/devnet/air/articles/air3-install-and-deployment-options.html).

To troubleshoot installation problems, create an empty file in your home
directory named _.airinstall.log_.

    touch .airinstall.log

The installer will write messages into this file.

## References

- [Installation and deployment options in Adobe AIR 3](http://www.adobe.com/devnet/air/articles/air3-install-and-deployment-options.html)
- [Blog note on reducing file size](http://www.shedosurashu.com/captive-runtime-not-what-i-thought-it-to-be)


CONTINUE READING:

[Installation and deployment options in Adobe AIR 3](http://www.adobe.com/devnet/air/articles/air3-install-and-deployment-options.html)



    adt -package -target apk-captive-runtime ...

