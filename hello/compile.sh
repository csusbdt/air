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

#  -library-path+=$AIR/lib/air/airglobal.swc  \
#  -load-config+=air-config.xml               \
