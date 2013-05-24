# Keystore Generation

The purpose of the scripts in this folder is to generate a self-signed
certificate to be used for signing the air package.

After using a certificate on a system, it is problematic to use a different
certificate to update or reinstall an air pack with the same application id,
because Adobe AIR will reject the new package if its certificate differs
an existing certificate.  These certifcates can be cached in your system in
unexpected ways.  For example, in a mac environment, I observed Adobe AIR
searching through the trash folder to locate an air file with the given id 
and use the certificate from it.

The scripts generate a self-signed certificate and stores this in a file 
called _keystore_.

Add the path to the keystore file to .gitignore to avoid exposing to outside.

ADVICE: don't regenerate the keystore after dong a test install, otherwise 
you will need to thoroughly clean your filesystem of old air packages, 
including emptying the trash (and maybe reinstalling AIR).
