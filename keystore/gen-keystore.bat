echo Generating keystore with self-signed certificate.


%AIR_SDK_HOME%\bin\adt -certificate       ^

                       -cn csusbdt        ^

                       -validityPeriod 25 ^

                       2048-RSA           ^

                       keystore           ^

                       1234
