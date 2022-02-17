//
//  sppermissions-swift.swift
//  sppermissions-unity
//
//  Created by Yuchen Zhang on 2022/2/16.
//

import Foundation
import UIKit
import SPPermissions
import SPPermissionsCamera
import SPPermissionsPhotoLibrary
import SPPermissionsNotification
import SPPermissionsMicrophone
import SPPermissionsCalendar
import SPPermissionsContacts
import SPPermissionsReminders
import SPPermissionsSpeechRecognizer
import SPPermissionsLocationWhenInUse
import SPPermissionsLocationAlways
import SPPermissionsMotion
import SPPermissionsMusic
import SPPermissionsBluetooth
import SPPermissionsTracking
import SPPermissionsFaceID
import SPPermissionsSiri
import SPPermissionsHealth

public class SPPermissionsSwift: NSObject, SPPermissionsDelegate, SPPermissionsDataSource {
    
    @objc public static let shared = SPPermissionsSwift()
    
    private var controllerTitleText: String? = nil
    private var controllerHeaderText: String? = nil
    private var controllerFooterText: String? = nil
    
    private var deniedAlertTitleText: String? = nil
    private var deniedAlertDescriptionText: String? = nil
    private var deniedAlertActionText: String? = nil
    private var deniedAlertCancelText: String? = nil
    
    private var dismissWhenAllPermissionsDeterminated: Bool = false
    private var showCloseButotn: Bool = true
    private var allowSwipeDismiss: Bool = true
    
    @objc public func popPermissionsList(_ permissionArray: [Int]) {
        let controller = SPPermissions.list(SPPermissionsSwift.createPermissions(permissionArray))
        
        if let title = controllerTitleText {
            controller.titleText = title
        }
        if let header = controllerHeaderText {
            controller.headerText = header
        }
        if let footer = controllerFooterText {
            controller.footerText = footer
        }
        
        controller.delegate = self
        controller.dataSource = self

        if (dismissWhenAllPermissionsDeterminated) {
            controller.dismissCondition = .allPermissionsDeterminated
        } else {
            controller.dismissCondition = .allPermissionsAuthorized
        }
        controller.showCloseButton = showCloseButotn
        controller.allowSwipeDismiss = allowSwipeDismiss
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            controller.present(on: topController)
        }
    }
    
    @objc public func popPermissionsDialog(_ permissionArray: [Int]) {
        let controller = SPPermissions.dialog(SPPermissionsSwift.createPermissions(permissionArray))
        
        if let title = controllerTitleText {
            controller.titleText = title
        }
        if let header = controllerHeaderText {
            controller.headerText = header
        }
        if let footer = controllerFooterText {
            controller.footerText = footer
        }
        
        controller.delegate = self
        controller.dataSource = self
        
        if (dismissWhenAllPermissionsDeterminated) {
            controller.dismissCondition = .allPermissionsDeterminated
        } else {
            controller.dismissCondition = .allPermissionsAuthorized
        }
        controller.showCloseButton = showCloseButotn
        controller.allowSwipeDismiss = allowSwipeDismiss
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            controller.present(on: topController)
        }
    }
    
    @objc public func popPermissionsNative(_ permissionArray: [Int]) {
        let controller = SPPermissions.native(SPPermissionsSwift.createPermissions(permissionArray))
        controller.delegate = self
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            controller.present(on: topController)
        }
    }
    
    @objc public func setControllerTitleText(_ text: String) {
        controllerTitleText = text
    }
    
    @objc public func setControllerHeaderText(_ text: String) {
        controllerHeaderText = text
    }
    
    @objc public func setControllerFooterText(_ text: String) {
        controllerFooterText = text
    }
    
    @objc public func setDeniedAlertTitleText(_ text: String) {
        deniedAlertTitleText = text
    }
    
    @objc public func setDeniedAlertDescriptionText(_ text: String) {
        deniedAlertDescriptionText = text
    }
    
    @objc public func setDeniedAlertActionText(_ text: String) {
        deniedAlertActionText = text
    }
    
    @objc public func setDeniedAlertCancelText(_ text: String) {
        deniedAlertCancelText = text
    }
    
    @objc public func setDismissWhenAllPermissionsDeterminated(_ value: Bool) {
        dismissWhenAllPermissionsDeterminated = value
    }
    
    @objc public func setShowCloseButton(_ value: Bool) {
        showCloseButotn = value
    }
    
    @objc public func setAllowSwipeDismiss(_ value: Bool) {
        allowSwipeDismiss = value
    }
    
    @objc public func getPermissionStatus(_ permission: Int) -> Bool {
        switch(SPPermissions.PermissionType(rawValue: permission)) {
        case .some(.camera):
            return SPPermissions.Permission.camera.authorized
        case .some(.notification):
            return SPPermissions.Permission.notification.authorized
        case .some(.photoLibrary):
            return SPPermissions.Permission.photoLibrary.authorized
        case .some(.microphone):
            return SPPermissions.Permission.microphone.authorized
        case .some(.calendar):
            return SPPermissions.Permission.calendar.authorized
        case .some(.contacts):
            return SPPermissions.Permission.contacts.authorized
        case .some(.reminders):
            return SPPermissions.Permission.reminders.authorized
        case .some(.speech):
            return SPPermissions.Permission.speech.authorized
        case .some(.locationWhenInUse):
            return SPPermissions.Permission.locationWhenInUse.authorized
        case .some(.locationAlways):
            return SPPermissions.Permission.locationAlways.authorized
        case .some(.motion):
            return SPPermissions.Permission.motion.authorized
        case .some(.mediaLibrary):
            return SPPermissions.Permission.mediaLibrary.authorized
        case .some(.bluetooth):
            return SPPermissions.Permission.bluetooth.authorized
        case .some(.tracking):
            return SPPermissions.Permission.tracking.authorized
        case .some(.faceID):
            return SPPermissions.Permission.faceID.authorized
        case .some(.siri):
            return SPPermissions.Permission.siri.authorized
        case .some(.health):
            return false
        case .none:
            return false
        }
    }
    
    private static func createPermissions(_ permissionArray : [Int]) -> [SPPermissions.Permission] {
        var permissions: [SPPermissions.Permission] = []
        for permission in permissionArray {
            switch (SPPermissions.PermissionType(rawValue: permission)) {
            case .some(.camera):
                permissions.append(.camera)
                break
            case .some(.notification):
                permissions.append(.notification)
                break
            case .some(.photoLibrary):
                permissions.append(.photoLibrary)
                break
            case .some(.microphone):
                permissions.append(.microphone)
                break
            case .some(.calendar):
                permissions.append(.calendar)
                break
            case .some(.contacts):
                permissions.append(.contacts)
                break
            case .some(.reminders):
                permissions.append(.reminders)
                break
            case .some(.speech):
                permissions.append(.speech)
                break
            case .some(.locationWhenInUse):
                permissions.append(.locationWhenInUse)
                break
            case .some(.locationAlways):
                permissions.append(.locationAlways)
                break
            case .some(.motion):
                permissions.append(.motion)
                break
            case .some(.mediaLibrary):
                permissions.append(.mediaLibrary)
                break
            case .some(.bluetooth):
                permissions.append(.bluetooth)
                break
            case .some(.tracking):
                permissions.append(.tracking)
                break
            case .some(.faceID):
                permissions.append(.faceID)
                break
            case .some(.siri):
                permissions.append(.siri)
                break
            case .some(.health):
                permissions.append(.health)
                break
            case .none:
                break
            }
        }
        return permissions
    }
    
// MARK: - SPPermissions Delegate
    public func didAllowPermission(_ permission: SPPermissions.Permission) {
        NSLog("[Swift] didAllowPermission \(permission)")
        SPPermissionsUnity.didAllowPermission(Int32(permission.type.rawValue));
    }
    
    public func didDeniedPermission(_ permission: SPPermissions.Permission) {
        NSLog("[Swift] didDenyPermission \(permission)")
        SPPermissionsUnity.didDenyPermission(Int32(permission.type.rawValue));
    }
    
    public func didHidePermissions(_ permissions: [SPPermissions.Permission]) {
        NSLog("[Swift] didHidePermissions \(permissions)")
        
        var permissionArray: [NSNumber] = []
        for permission in permissions {
            permissionArray.append(NSNumber(value: permission.type.rawValue))
        }
        SPPermissionsUnity.didHidePermissions(permissionArray)
    }
    
// MARK: - SPPermisisons DataSource
    public func configure(_ cell: SPPermissionsTableViewCell, for permission: SPPermissions.Permission) {
        
    }
    
    public func deniedAlertTexts(for permission: SPPermissions.Permission) -> SPPermissionsDeniedAlertTexts? {
        let texts = SPPermissionsDeniedAlertTexts()
        if let title = deniedAlertTitleText {
            texts.titleText = title
        } else {
            //return .default
        }
        
        if let description = deniedAlertDescriptionText {
            texts.descriptionText = description
        } else {
            //return .default
        }
        
        if let action = deniedAlertActionText {
            texts.actionText = action
        } else {
            //return .default
        }
        
        if let cancel = deniedAlertCancelText {
            texts.cancelText = cancel
        } else {
            //return.default
        }
        
        return texts
    }
}
