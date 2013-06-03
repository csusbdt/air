# Manual Tests

## test-native-osx

- Uninstall app. 
- Uninstall air (optional).
- In a dedicated terminal window, cd to web folder and run __node main.js __.
- Set props.properties to 1.0.1.
- Run __ant web-native-osx__.
- Set props.properties to 1.0.0.
- Run __ant package-native-osx__.
- Mount temp/hello-air-1.0.0.dmg and run installer.
- Verify that app is installed and version 1.0.1.

## test-captive-osx

- Uninstall air (optional).
- In a dedicated terminal window, cd to web folder and run __node main.js __.
- Set props.properties to 1.0.1.
- Run __ant web-captive-osx__ in a dedicated terminal window.
- Set props.properties to 1.0.0.
- Run __ant package-captive-osx__.
- Mount temp/hello-air-1.0.0.dmg and run app.
- Verify that app version 1.0.1 is installed.

