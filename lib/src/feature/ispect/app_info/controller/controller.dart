import 'dart:io';

import 'package:base_starter/src/common/ui/widgets/dialogs/toaster.dart';
import 'package:base_starter/src/common/utils/global_variables.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoController extends ChangeNotifier {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;
  PackageInfo? _packageInfo;

  PackageInfo? get packageInfo => _packageInfo;
  IosDeviceInfo? get iosDeviceInfo => _iosDeviceInfo;
  AndroidDeviceInfo? get androidDeviceInfo => _androidDeviceInfo;

  Future<void> loadAll() async {
    try {
      await _loadPackageInfo();
      if (Platform.isIOS) {
        _iosDeviceInfo = await _deviceInfo.iosInfo;
      } else if (Platform.isAndroid) {
        _androidDeviceInfo = await _deviceInfo.androidInfo;
      }
    } on Exception catch (e, st) {
      talker.handle(e, st);
      await Toaster.showErrorToast(
        navigatorKey.currentContext!,
        title: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> _loadPackageInfo() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();
      notifyListeners();
    } on Exception catch (e, st) {
      talker.handle(e, st);
      await Toaster.showErrorToast(
        navigatorKey.currentContext!,
        title: e.toString(),
      );
    }
  }

  Future<String> allData() async {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln('App Info');
    buffer.writeln('App Name: ${packageInfo!.appName}');
    buffer.writeln('Package Name: ${packageInfo!.packageName}');
    buffer.writeln('Version: ${packageInfo!.version}');
    buffer.writeln('Build Number: ${packageInfo!.buildNumber}');
    buffer.writeln('Device Info');
    if (Platform.isIOS) {
      buffer.writeln('Name: ${iosDeviceInfo!.name}');
      buffer.writeln('System Name: ${iosDeviceInfo!.systemName}');
      buffer.writeln('System Version: ${iosDeviceInfo!.systemVersion}');
      buffer.writeln('Model: ${iosDeviceInfo!.model}');
      buffer.writeln('Localized Model: ${iosDeviceInfo!.localizedModel}');
      buffer.writeln(
        'Identifier For Vendor: ${iosDeviceInfo!.identifierForVendor}',
      );
    } else if (Platform.isAndroid) {
      buffer.writeln('Version: ${androidDeviceInfo!.version}');
      buffer.writeln('Board: ${androidDeviceInfo!.board}');
      buffer.writeln('Bootloader: ${androidDeviceInfo!.bootloader}');
      buffer.writeln('Brand: ${androidDeviceInfo!.brand}');
      buffer.writeln('Device: ${androidDeviceInfo!.device}');
      buffer.writeln('Display: ${androidDeviceInfo!.display}');
      buffer.writeln('Fingerprint: ${androidDeviceInfo!.fingerprint}');
      buffer.writeln('Hardware: ${androidDeviceInfo!.hardware}');
      buffer.writeln('Host: ${androidDeviceInfo!.host}');
      buffer.writeln('Id: ${androidDeviceInfo!.id}');
      buffer.writeln('Manufacturer: ${androidDeviceInfo!.manufacturer}');
      buffer.writeln('Model: ${androidDeviceInfo!.model}');
      buffer.writeln('Product: ${androidDeviceInfo!.product}');
      buffer.writeln('Tags: ${androidDeviceInfo!.tags}');
      buffer.writeln('Type: ${androidDeviceInfo!.type}');
      buffer.writeln('Android ID: ${androidDeviceInfo!.id}');
    }
    return buffer.toString();
  }
}
