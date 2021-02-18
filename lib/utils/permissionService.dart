import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future getPermission(BuildContext context) async {
    var permissions = [Permission.storage, Permission.notification];

    for (var permission in permissions) {
      await requestPermission(permission);
    }
    return true;
  }

  static Future requestPermission(Permission permission) async {
    var status = await permission.status;
    if (!status.isGranted) {
      var newstatus = await permission.request().isGranted;
      return newstatus;
    } else
      return true;
  }
}
