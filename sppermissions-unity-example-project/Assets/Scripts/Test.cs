using UnityEngine;

public class Test : MonoBehaviour
{
    [SerializeField] private SPPermissionsUnityController _controller;

    private void Start()
    {
        _controller.SetControllerTitleText("This is title text");
        _controller.SetDeniedAlertTitleText("This is title text");
    }

    public void PopPermissionsList()
    {
        PermissionType[] permissions = { PermissionType.Camera,
                                        PermissionType.Microphone,
                                        PermissionType.PhotoLibrary,
                                        PermissionType.Notification,
                                        PermissionType.LocationWhenInUse,
                                        PermissionType.Health };
        _controller.PopPermissionsList(permissions);
    }

    public void PopPermissionsDialog()
    {
        PermissionType[] permissions = { PermissionType.Camera,
                                        PermissionType.Microphone,
                                        PermissionType.PhotoLibrary,
                                        PermissionType.Notification,
                                        PermissionType.LocationWhenInUse,
                                        PermissionType.Health };
        _controller.PopPermissionsDialog(permissions);
    }

    public void PopPermissionsNative()
    {
        PermissionType[] permissions = { PermissionType.Camera,
                                        PermissionType.Microphone,
                                        PermissionType.PhotoLibrary,
                                        PermissionType.Notification,
                                        PermissionType.LocationWhenInUse,
                                        PermissionType.Health };
        _controller.PopPermissionsNative(permissions);
    }
}
