using System.IO;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEditor.iOS.Xcode;

public static class SwiftPostProcess
{
    [PostProcessBuild]
    public static void OnPostProcessBuild(BuildTarget buildTarget, string buildPath)
    {
        if (buildTarget == BuildTarget.iOS)
        {
            // For build settings
            var projPath = buildPath + "/Unity-Iphone.xcodeproj/project.pbxproj";
            var proj = new PBXProject();
            proj.ReadFromFile(projPath);

            var unityFrameworkTargetGuid = proj.GetUnityFrameworkTargetGuid();
            var mainTargetGuid = proj.GetUnityMainTargetGuid();

            proj.AddBuildProperty(unityFrameworkTargetGuid, "LIBRARY_SEARCH_PATHS", "$(SDKROOT)/usr/lib/swift");
            proj.AddBuildProperty(unityFrameworkTargetGuid, "LIBRARY_SEARCH_PATHS", "$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)");
            // This is optional
            proj.SetBuildProperty(mainTargetGuid, "SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD", "NO");

            proj.WriteToFile(projPath);

            // For info.plist
            string plistPath = buildPath + "/Info.plist";
            PlistDocument plist = new PlistDocument();
            plist.ReadFromFile(plistPath);

            PlistElementDict rootDict = plist.root;
            // Only uncomment those you need.
            rootDict.SetString("NSCameraUsageDescription", "The app needs to access camera");
            rootDict.SetString("NSContactsUsageDescription", "The app needs to access contacts");
            rootDict.SetString("NSCalendarsUsageDescription", "The app needs to access calendars");
            rootDict.SetString("NSMicrophoneUsageDescription", "The app needs to access microphone");
            rootDict.SetString("NSAppleMusicUsageDescription", "The app needs to access music");
            rootDict.SetString("NSRemindersUsageDescription", "The app needs to access reminders");
            rootDict.SetString("NSPhotoLibraryUsageDescription", "The app needs to access photo library");
            rootDict.SetString("NSPhotoLibraryAddUsageDescription", "The app needs to add to photo library");
            rootDict.SetString("NSSpeechRecognitionUsageDescription", "The app needs to access speech recognizer");
            rootDict.SetString("NSMotionUsageDescription", "The app needs to access motion");
            rootDict.SetString("NSLocationWhenInUseUsageDescription", "The app needs to access location when in use");
            rootDict.SetString("NSLocationAlwaysAndWhenInUseUsageDescription", "The app needs to access location always and when in use");
            rootDict.SetString("NSBluetoothAlwaysUsageDescription", "The app needs to access location always");
            rootDict.SetString("NSUserTrackingUsageDescription", "The app needs to access tracking");
            rootDict.SetString("NSFaceIDUsageDescription", "The app needs to access face ID");
            rootDict.SetString("NSSiriUsageDescription", "The app needs to access siri");
            rootDict.SetString("NSHealthUpdateUsageDescription", "The app needs to access health update");
            rootDict.SetString("NSHealthShareUsageDescription", "The app needs to access health share");

            File.WriteAllText(plistPath, plist.WriteToString());
        }
    }

}
