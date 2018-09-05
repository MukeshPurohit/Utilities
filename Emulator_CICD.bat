node {

   dir('C:/Users/capeuser/AppData/Local/Android/Sdk/tools/bin')
   {    
       bat(/echo y | sdkmanager --update/)
       bat(/echo y | sdkmanager system-images;android-25;google_apis;x86/)
       bat(/echo y | sdkmanager --licenses/)
       bat(/echo y | avdmanager create avd -f --name "processing-phone-%BUILD_NUMBER%" --package "system-images;android-25;google_apis;x86" --abi "google_apis\/x86" -d "Nexus 5"/)
       bat 'echo y | avdmanager list avd'
   }
   dir('C:/Users/capeuser/AppData/Local/Android/Sdk/tools')
   {    
       bat(/START \/B C:\/Users\/capeuser\/AppData\/Local\/Android\/Sdk\/tools\/emulator -avd "processing-phone-%BUILD_NUMBER%" -netspeed full -gpu off -netdelay none -verbose -ports 5584,5585 -wipe-data -no-boot-anim -no-audio -skin 480x800 -memory 2048/)
   }
    
   dir('C:\\Users\\capeuser\\AppData\\Local\\Android\\Sdk\\platform-tools')
   {    
        bat(/adb wait-for-device/)       
        sleep 100

        bat(/adb devices/)
        sleep 120

    bat(/adb -s "emulator-5584" shell input keyevent 82/)   
    sleep 100

    bat(/adb -s "emulator-5584" install "C:\\projects\\android-sunflower\\app\\build\\outputs\\apk\\debug\\app-debug.apk"/)            
    sleep 100    

    bat(/adb shell pm list packages/)                
    }
    sleep 100
}


       

	   
cd %ANDROID_HOME%\tools\bin

set Number=%BUILD_NUMBER%

echo %Number%

echo y | sdkmanager --update

echo y | sdkmanager "system-images;android-25;google_apis;x86"

echo y | sdkmanager --licenses

echo y | avdmanager create avd -f --name "processing-phone-%Number%" --package "system-images;android-25;google_apis;x86" --abi google_apis/x86 -d "Nexus 5"

echo y | avdmanager list avd

cd %ANDROID_HOME%\tools

START /B %ANDROID_HOME%\tools\emulator -avd processing-phone-%Number% -netspeed full -gpu off -netdelay none -verbose -ports 5584,5585 -wipe-data -no-boot-anim -no-audio -skin 480x800 -memory 2048 > C:\emulatorLogs-%Number%.txt

cd C:\Users\capeuser\AppData\Local\Android\Sdk\platform-tools

waitfor SomethingThatIsNeverHappening /t 30 2>NUL

adb wait-for-device

adb devices

waitfor SomethingThatIsNeverHappening /t 30 2>NUL

adb -s "emulator-5584" shell input keyevent 82

waitfor SomethingThatIsNeverHappening /t 30 2>NUL

adb -s "emulator-5584" install "C:\projects\android-sunflower\app\build\outputs\apk\debug\app-debug.apk"

cd C:\Users\capeuser\AppData\Local\Android\Sdk\platform-tools
adb shell pm list packages 

::cd C:\workspace\Build\
::gradlew installDebugAndroidTest

::adb -s "emulator-5584" uninstall com.example.capeuser.crunchifycalculator
::adb -s "emulator-5584" install "C:\workspace\Build\app\build\outputs\apk\debug\app-debug.apk"
::echo "We have now finished with install, uninstall and install APK operation !!!"



echo "Lets wait for 600 seconds to launch Emulator interactively and see if APK is installed...".

::BUILD_ID=dontKillMe waitfor SomethingThatIsNeverHappening /t 600 2>NUL
exit 0
