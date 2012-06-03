#copied from the wiki
git submodule update --init --recursive
git clone https://github.com/ghc/ghc.git
cd ghc
./sync-all get

#Check out the ios branch of each of the GHC iOS forks. 
#If you have read+write access, use https://$USER@github.com in each URL. Start with ghc:
git remote add ghc-ios https://github.com/ghc-ios/ghc.git
git fetch ghc-ios
git checkout -t ghc-ios/ios

#Next, the base package:
cd libraries/base
git remote add ghc-ios https://github.com/ghc-ios/packages-base.git
git fetch ghc-ios
git checkout -t ghc-ios/ios
cd ../..

#Next, the unix package:
cd libraries/unix
git remote add ghc-ios https://github.com/ghc-ios/packages-unix.git
git fetch ghc-ios
git checkout -t ghc-ios/ios
cd ../..

#Next, the Cabal package:
cd libraries/Cabal
git remote add ghc-ios https://github.com/ghc-ios/packages-Cabal.git
git fetch ghc-ios
git checkout -t ghc-ios/ios

cd ../..

#Finally, hsc2hs:
cd utils/hsc2hs
git remote add ghc-ios https://github.com/ghc-ios/hsc2hs.git
git fetch ghc-ios
git checkout -t ghc-ios/ios
cd ../..

#Add a build configuration file:
cat > mk/build.mk << EOF
SRC_HC_OPTS        = -H64m -O2
SplitObjs          = NO
HADDOCK_DOCS       = NO
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO
INTEGER_LIBRARY    = integer-simple
EOF

#Generate configure scripts:
perl boot

#Bring in the environment variables from env.sh:
. ./env.sh

#Run the configure scripts:
./config.sh

#Make & install:
make
sudo mkdir -p /usr/local/ghc-iphone/bin
sudo chown $SUDO_USER /usr/local/ghc-iphone/
make install

#build cabal
cd libraries/Cabal/Cabal
cabal install
cd ../cabal-install
cabal install --bindir=/usr/local/ghc-iphone/bin

#get the OpenGL library to build the testapp
cd ../../../../TestApp
. ./env.sh
cabal install OpenGL
#build the haskell library
sudo chmod 666 haskell_stub.hs
arm-apple-darwin10-ghc -threaded haskell.hs
