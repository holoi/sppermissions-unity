//
//  sppermissions_unity.h
//  sppermissions-unity
//
//  Created by Yuchen Zhang on 2022/2/16.
//

#ifndef sppermissions_unity_h
#define sppermissions_unity_h

#import <Foundation/Foundation.h>

typedef enum {
    camera = 0,
    notification = 2,
    photoLibrary = 1,
    microphone = 3,
    calendar = 4,
    contacts = 5,
    reminders = 6,
    speech = 7,
    locationWhenInUse = 9,
    locationAlways = 10,
    motion = 11,
    mediaLibrary = 12,
    bluetooth = 13,
    tracking = 14,
    faceID = 15,
    siri = 16,
    health = 17
} PermissionType;

@interface SPPermissionsUnity: NSObject

+ (void)didAllowPermission:(int)permission;
+ (void)didDenyPermission:(int)permission;
+ (void)didHidePermissions:(NSArray<NSNumber *> *)permissions;

@end

#endif /* sppermissions_unity_h */
