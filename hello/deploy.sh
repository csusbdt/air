export APP_MSG="You got this app through a heroku web application."
mxmlc \
  -debug=false                               \
  -omit-trace-statements=true                \
  -title="Hello AIR"                         \
  -description="Example Application"         \
  -publisher="David Turner"                  \
  -creator="David Turner"                    \
  -define+=CONFIG::message,"'$APP_MSG'" --   \
  -library-path+=$AIR/lib/air/airglobal.swc  \
  Main.as

#  -library-path+=$AIR/lib/air/airglobal.swc  \
#  -load-config+=air-config.xml               \

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

cp Main.swf ../web/public/hello/

