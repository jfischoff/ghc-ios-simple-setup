ghc-ios-simple-setup
====================

A simple way to build the ios ghc branch.

```bash
git clone git://github.com/jfischoff/ghc-ios-simple-setup.git   
cd ghc-ios-simple-setup   
chmod +x install.sh
sudo ./install.sh   
```
This should build a library called haskell.a in the ghc-ios-simple-setup/TestApp directory.   
  
Open the ghc-ios-simple-setup/TestApp/TestApp.xcodeproj and build the project using a scheme for an iOS device.   
  
Your done!  
  
For a more detailed explaination of the building process (what install.sh is actually doing) see https://github.com/ghc-ios/ghc/wiki