//
//  sppermissions_unity.m
//  sppermissions-unity
//
//  Created by Yuchen Zhang on 2022/2/16.
//

#import "sppermissions_unity.h"
#import "sppermissions_unity-Swift.h"

typedef void (*DidAllowPermission)(int permission);
DidAllowPermission DidAllowPermissionDelegate = NULL;

typedef void (*DidDenyPermission)(int permission);
DidDenyPermission DidDenyPermissionDelegate = NULL;

typedef void (*DidHidePermissions)(int permissions[], int count);
DidHidePermissions DidHidePermissionsDelegate = NULL;

@implementation SPPermissionsUnity

+ (void)didAllowPermission:(int)permission {
    if (DidAllowPermissionDelegate != NULL) {
        DidAllowPermissionDelegate(permission);
    }
}

+ (void)didDenyPermission:(int)permission {
    if (DidDenyPermissionDelegate != NULL) {
        DidDenyPermissionDelegate(permission);
    }
}

+ (void)didHidePermissions:(NSArray<NSNumber *> *)permissions {
    if (DidHidePermissionsDelegate != NULL) {
        int count = (int)[permissions count];
        int permissionArray[count];
        for (int i = 0; i < count; i++) {
            permissionArray[i] = [permissions[i] intValue];
        }
        DidHidePermissionsDelegate(permissionArray, count);
    }
}

@end

extern "C" {
    
void SPPermissionsUnity_PopPermissionsList(int permissions[], int count) {
    NSMutableArray<NSNumber *> *permissionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        NSNumber *num = [[NSNumber alloc] initWithInt:permissions[i]];
        [permissionArray addObject:num];
    }
    [[SPPermissionsSwift shared] popPermissionsList:permissionArray];
}
    
void SPPermissionsUnity_PopPermissionsDialog(int permissions[], int count) {
    NSMutableArray<NSNumber *> *permissionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        NSNumber *num = [[NSNumber alloc] initWithInt:permissions[i]];
        [permissionArray addObject:num];
    }
    [[SPPermissionsSwift shared] popPermissionsDialog:permissionArray];
}

void SPPermissionsUnity_PopPermissionsNative(int permissions[], int count) {
    NSMutableArray<NSNumber *> *permissionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        NSNumber *num = [[NSNumber alloc] initWithInt:permissions[i]];
        [permissionArray addObject:num];
    }
    [[SPPermissionsSwift shared] popPermissionsNative:permissionArray];
}

void SPPermissionsUnity_SetControllerTitleText(const char *text) {
    [[SPPermissionsSwift shared] setControllerTitleText:[NSString stringWithUTF8String:text]];
}

void SPPermissionsUnity_SetControllerHeaderText(const char *text) {
    [[SPPermissionsSwift shared] setControllerHeaderText:[NSString stringWithUTF8String:text]];
}

void SPPermissionsUnity_SetControllerFooterText(const char *text) {
    [[SPPermissionsSwift shared] setControllerFooterText:[NSString stringWithUTF8String:text]];
}

void SPPermissionsUnity_SetDeniedAlertTitleText(const char *text) {
    [[SPPermissionsSwift shared] setDeniedAlertTitleText:[NSString stringWithUTF8String:text]];
}

void SPPermissionsUnity_SetDeniedAlertDescriptionText(const char *text) {
    [[SPPermissionsSwift shared] setDeniedAlertDescriptionText:[NSString stringWithUTF8String:text]];
}

void SPPermissionsUnity_SetDeniedAlertActionText(const char *text) {
    [[SPPermissionsSwift shared] setDeniedAlertActionText:[NSString stringWithUTF8String:text]];
}

void SPPermissionsUnity_SetDeniedAlertCancelText(const char *text) {
    [[SPPermissionsSwift shared] setDeniedAlertCancelText:[NSString stringWithUTF8String:text]];
}

void SPPermissionsUnity_SetDidAllowPermissionDelegate(DidAllowPermission callback) {
    DidAllowPermissionDelegate = callback;
}

void SPPermissionsUnity_SetDidDenyPermissionDelegate(DidDenyPermission callback) {
    DidDenyPermissionDelegate = callback;
}

void SPPermissionsUnity_SetDidHidePermissionsDelegate(DidHidePermissions callback) {
    DidHidePermissionsDelegate = callback;
}

void SPPermissionsUnity_SetDismissWhenAllPermissionsDeterminated(bool value) {
    [[SPPermissionsSwift shared] setDismissWhenAllPermissionsDeterminated:value];
}

void SPPermissionsUnity_SetShowCloseButton(bool value) {
    [[SPPermissionsSwift shared] setShowCloseButton:value];
}

void SPPermissionsUnity_SetAllowSwipeDismiss(bool value) {
    [[SPPermissionsSwift shared] setAllowSwipeDismiss:value];
}

bool SPPermissionsUnity_GetPermissionStatus(int permission) {
    return [[SPPermissionsSwift shared] getPermissionStatus:permission];
}
    
}
