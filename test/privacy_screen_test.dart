import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:privacy_screen/privacy_screen.dart';
import 'package:privacy_screen/src/privacy_screen_method_channel.dart';
import 'package:privacy_screen/src/privacy_screen_platform_interface.dart';

class _FakePrivacyScreenPlatform
    with MockPlatformInterfaceMixin
    implements PrivacyScreenPlatform {
  bool? result = true;

  @override
  Future<bool?> updateConfig({
    required PrivacyIosOptions iosOptions,
    required PrivacyAndroidOptions androidOptions,
    required Color backgroundColor,
    required PrivacyBlurEffect blurEffect,
  }) async {
    return result;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final initialPlatform = PrivacyScreenPlatform.instance;

  tearDown(() {
    PrivacyScreenPlatform.instance = initialPlatform;
  });

  test('uses the method channel platform by default', () {
    expect(initialPlatform, isA<MethodChannelPrivacyScreen>());
  });

  test('enable returns the native update result', () async {
    final fakePlatform = _FakePrivacyScreenPlatform();
    PrivacyScreenPlatform.instance = fakePlatform;

    expect(await PrivacyScreen.instance.enable(), isTrue);

    fakePlatform.result = false;
    expect(await PrivacyScreen.instance.enable(), isFalse);
  });
}
