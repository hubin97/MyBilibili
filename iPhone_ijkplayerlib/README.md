
//编译时根据需求替换Debug/Release 

合并Debug版本
iPhone_ijkplayerlib MyMac$ lipo -create /Users/Mac/Desktop/iPhone_ijkplayerlib/Debug-iphoneos/IJKMediaFramework.framework/IJKMediaFramework /Users/Mac/Desktop/iPhone_ijkplayerlib/Debug-iphonesimulator/IJKMediaFramework.framework/IJKMediaFramework -output IJKMediaFramework

合并Release版本
iPhone_ijkplayerlib MyMac$ lipo -create /Users/Mac/Desktop/iPhone_ijkplayerlib/Release-iphoneos/IJKMediaFramework.framework/IJKMediaFramework /Users/Mac/Desktop/iPhone_ijkplayerlib/Release-iphonesimulator/IJKMediaFramework.framework/IJKMediaFramework -output IJKMediaFramework

#==========================
Build iOS

git clone https://github.com/Bilibili/ijkplayer.git ijkplayer-ios
cd ijkplayer-ios
git checkout -B latest k0.7.7.1

./init-ios.sh

cd ios
./compile-ffmpeg.sh clean
./compile-ffmpeg.sh all

# Demo
#     open ios/IJKMediaDemo/IJKMediaDemo.xcodeproj with Xcode
# 
# Import into Your own Application
#     Select your project in Xcode.
#     File -> Add Files to ... -> Select ios/IJKMediaPlayer/IJKMediaPlayer.xcodeproj
#     Select your Application's target.
#     Build Phases -> Target Dependencies -> Select IJKMediaFramework
#     Build Phases -> Link Binary with Libraries -> Add:
#         IJKMediaFramework.framework
#
#         AudioToolbox.framework
#         AVFoundation.framework
#         CoreGraphics.framework
#         CoreMedia.framework
#         CoreVideo.framework
#         libbz2.tbd
#         libz.tbd
#         MediaPlayer.framework
#         MobileCoreServices.framework
#         OpenGLES.framework
#         QuartzCore.framework
#         UIKit.framework
#         VideoToolbox.framework
#
#         ... (Maybe something else, if you get any link error)
# 
#==========================
