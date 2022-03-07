using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace SPPermissions.Unity
{
    public class SPPermissionsController : MonoBehaviour
    {
        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_PopPermissionsList(int[] permisisons, int count);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_PopPermissionsDialog(int[] permissions, int count);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_PopPermissionsNative(int[] permissions, int count);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetControllerTitleText(string text);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetControllerHeaderText(string text);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetControllerFooterText(string text);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetDeniedAlertTitleText(string text);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetDeniedAlertDescriptionText(string text);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetDeniedAlertActionText(string text);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetDeniedAlertCancelText(string text);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetDidAllowPermissionDelegate(DidAllowPermission callback);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetDidDenyPermissionDelegate(DidDenyPermission callback);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetDidHidePermissionsDelegate(DidHidePermissions callback);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetDismissWhenAllPermissionsDeterminated(bool value);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetShowCloseButton(bool value);

        [DllImport("__Internal")]
        private static extern void SPPermissionsUnity_SetAllowSwipeDismiss(bool value);

        [DllImport("__Internal")]
        private static extern bool SPPermissionsUnity_GetPermissionStatus(int permission);

        private delegate void DidAllowPermission(int permission);
        [AOT.MonoPInvokeCallback(typeof(DidAllowPermission))]
        private static void OnDidAllowPermission(int permission)
        {
            Debug.Log($"OnDidAllowPermission {(PermissionType)permission}");
            s_didAllowPermissionType = (PermissionType)permission;
            s_didAllowPermission = true;
        }

        private delegate void DidDenyPermission(int permission);
        [AOT.MonoPInvokeCallback(typeof(DidDenyPermission))]
        private static void OnDidDenyPermission(int permission)
        {
            Debug.Log($"OnDidDenyPermission {(PermissionType)permission}");
            s_didDenyPermissionType = (PermissionType)permission;
            s_didDenyPermission = true;
        }

        private delegate void DidHidePermissions(IntPtr permissions, int count);
        [AOT.MonoPInvokeCallback(typeof(DidHidePermissions))]
        private static void OnDidHidePermissions(IntPtr permissions, int count)
        {
            int[] permissionArray = new int[count];
            Marshal.Copy(permissions, permissionArray, 0, count);

            s_didHidePermissionsType = new PermissionType[count];
            Debug.Log($"OnHidePermissions count {count}");
            for (int i = 0; i < count; i++)
            {
                Debug.Log($"{(PermissionType)permissionArray[i]}");
                s_didHidePermissionsType[i] = (PermissionType)permissionArray[i];
            }

        }

        private static bool s_didAllowPermission;

        private static PermissionType s_didAllowPermissionType;

        private static bool s_didDenyPermission;

        private static PermissionType s_didDenyPermissionType;

        private static bool s_didHidePermissions;

        private static PermissionType[] s_didHidePermissionsType;

        public static event Action<PermissionType> DidAllowPermissioneEvent;

        public static event Action<PermissionType> DidDenyPermissionEvent;

        public static event Action<PermissionType[]> DidHidePermissionsEvent;

        private void Awake()
        {
            SPPermissionsUnity_SetDidAllowPermissionDelegate(OnDidAllowPermission);
            SPPermissionsUnity_SetDidDenyPermissionDelegate(OnDidDenyPermission);
            SPPermissionsUnity_SetDidHidePermissionsDelegate(OnDidHidePermissions);
        }

        private void OnDestroy()
        {
            SPPermissionsUnity_SetDidAllowPermissionDelegate(null);
            SPPermissionsUnity_SetDidDenyPermissionDelegate(null);
            SPPermissionsUnity_SetDidHidePermissionsDelegate(null);
        }

        private void Update()
        {
            if (s_didAllowPermission)
            {
                DidAllowPermissioneEvent?.Invoke(s_didAllowPermissionType);
                s_didAllowPermission = false;
            }

            if (s_didDenyPermission)
            {
                DidDenyPermissionEvent?.Invoke(s_didDenyPermissionType);
                s_didDenyPermission = false;
            }

            if (s_didHidePermissions)
            {
                DidHidePermissionsEvent?.Invoke(s_didHidePermissionsType);
                s_didHidePermissions = false;
            }
        }

        public void PopPermissionsList(PermissionType[] permissions)
        {
            int[] permissionArray = new int[permissions.Length];
            for (int i = 0; i < permissions.Length; i++)
            {
                permissionArray[i] = (int)permissions[i];
            }
            SPPermissionsUnity_PopPermissionsList(permissionArray, permissions.Length);
        }

        public void PopPermissionsDialog(PermissionType[] permissions)
        {
            int[] permissionArray = new int[permissions.Length];
            for (int i = 0; i < permissions.Length; i++)
            {
                permissionArray[i] = (int)permissions[i];
            }
            SPPermissionsUnity_PopPermissionsDialog(permissionArray, permissions.Length);
        }

        public void PopPermissionsNative(PermissionType[] permissions)
        {
            int[] permissionArray = new int[permissions.Length];
            for (int i = 0; i < permissions.Length; i++)
            {
                permissionArray[i] = (int)permissions[i];
            }
            SPPermissionsUnity_PopPermissionsNative(permissionArray, permissions.Length);
        }

        public void SetControllerTitleText(string text)
        {
            SPPermissionsUnity_SetControllerTitleText(text);
        }

        public void SetControllerHeaderText(string text)
        {
            SPPermissionsUnity_SetControllerHeaderText(text);
        }

        public void SetControllerFooterText(string text)
        {
            SPPermissionsUnity_SetControllerFooterText(text);
        }

        public void SetDeniedAlertTitleText(string text)
        {
            SPPermissionsUnity_SetDeniedAlertTitleText(text);
        }

        public void SetDeniedAlertDescriptionText(string text)
        {
            SPPermissionsUnity_SetDeniedAlertDescriptionText(text);
        }

        public void SetDeniedAlertActionText(string text)
        {
            SPPermissionsUnity_SetDeniedAlertActionText(text);
        }

        public void SetDeniedAlertCancelText(string text)
        {
            SPPermissionsUnity_SetDeniedAlertCancelText(text);
        }

        public void SetDismissWhenAllPermissionsDeterminated(bool value)
        {
            SPPermissionsUnity_SetDismissWhenAllPermissionsDeterminated(value);
        }

        public void SetShowCloseButton(bool value)
        {
            SPPermissionsUnity_SetShowCloseButton(value);
        }

        public void SetAllowSwipeDismiss(bool value)
        {
            SPPermissionsUnity_SetAllowSwipeDismiss(value);
        }

        public bool GetPermissionStatus(PermissionType permission)
        {
            return SPPermissionsUnity_GetPermissionStatus((int)permission);
        }
    }
}