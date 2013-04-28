# Hello Project

## Overview

The _hello_ folder of this repository documents a process
to build an application with the following characteristics.

- The application says _hello_ in a window -- that's all it does.
- All neccesary files are developed with a text editor or generated with command line tools.
- The application runs in Adobe AIR in OS X and Windows desktop environments.
- The application installs and updates from a website.
- All development is done on a mac.

Note that this process can easily be carried out in Windows
with small adjustments.

## Prerequisites

Download Adobe AIR SDK and expand into the following location.

    $HOME/apps/AIRSDK_Compiler

Add the following lines to _~/.bash_profile_.
(Create .bash_profile in your home folder if not there.)

    export AIR=$HOME/apps/AIRSDK_Compiler
    export PATH=$PATH:$AIR/bin

(Restart terminal window after making above changes.)

## The Process

In your home directory, create a folder named _hello_ to contain the project assets.

    cd
    mkdir hello
    cd hello

Create file _application.xml_ by modifying a copy of an example.

    cp $AIR/samples/descriptor-sample.xml application.xml

See _hello/application.xml_ in the repository to see the changes I made.

Create file _Main.as_ with the following contents.

```
package {

import flash.display.Sprite;

   public class Main extends Sprite
   { 
      public function Main() : void
      { 
         trace("OK");
         trace(CONFIG::message);
      }
   }
}
```

Create file _compile.sh_ with the following contents.

```
export APP_MSG="message from the compile script"
mxmlc \
  -debug=false                               \
  -omit-trace-statements=false               \
  -title="Hello Desktop AIR Application"     \
  -description="Example Application"         \
  -publisher="David Turner"                  \
  -creator="David Turner"                    \
  -define+=CONFIG::message,"'$APP_MSG'" --   \
  Main.as
```

Change the permissions to make compile.sh executable.

    chmod +x compile.sh

Compile Main.as to produce Main.swf.

    ./compile.sh

Create file _run.sh_ with the following contents.

```
adl application.xml
```

Change the permissions to make run.sh executable and then run it.

    chmod +x run.sh
    ./run.sh

Create file _create_keystore.sh_ with the following contents.

```
adt                  \
   -certificate      \
   -cn csusbdt       \
   -validityPeriod 5 \
   2048-RSA          \
   keystore.p12      \
   1234
```

Change the permissions to make the script executable and then run it
to generate a self-signed certifacte and store in _keystore.p12_.

    chmod +x create_keystore.sh
    ./create_keystore.sh

Create file _package.sh_ with the following contents.

```
adt                        \
   -package                \
   -storetype pkcs12       \
   -keystore keystore.p12  \
   -storepass 1234         \
   -target air             \
   hello.air               \
   application.xml         \
   Main.swf                \
   icons
```

Change the permissions to make the script executable and then run it
to generate _hello.air_.

    chmod +x package.sh
    ./package.sh


