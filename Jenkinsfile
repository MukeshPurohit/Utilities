node {
   stage('Preparation') {
      git 'https://github.com/MukeshPurohit/android-sunflower.git'
   }
   stage('Build') {
         bat(/gradlew assembleDebug/)
      }
   stage('Publish') {
         hockeyApp applications: [[apiToken: '72dcd8aed72142afb354d35ba7d8702f', downloadAllowed: true, filePath: 'app\\build\\outputs\\apk\\debug\\app-debug.apk', mandatory: false, notifyTeam: false, releaseNotesMethod: none(), uploadMethod: appCreation(false)]], debugMode: false, failGracefully: false
      }
      
   }