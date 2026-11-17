
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacy_screen/src/privacy_helpers.dart';
import 'package:privacy_screen/src/privacy_screen_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelPrivacyScreen();
  final methodCalls = <MethodCall>[];

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(platform.methodChannel, (methodCall) async {
      methodCalls.add(methodCall);
      return true;
    });
  });

  tearDown(() {
    methodCalls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(platform.methodChannel, null);
  });

  test('updateConfig sends the expected native configuration', () async {
    final result = await platform.updateConfig(
      iosOptions: const PrivacyIosOptions(
        enablePrivacy: true,
        privacyImageName: 'LaunchImage',
        autoLockAfterSeconds: 5,
        lockTrigger: IosLockTrigger.willResignActive,
      ),
      androidOptions: const PrivacyAndroidOptions(
        enableSecure: false,
        autoLockAfterSeconds: 10,
      ),
      backgroundColor: const Color(0x66445566),
      blurEffect: PrivacyBlurEffect.dark,
    );

    expect(result, isTrue);
    expect(methodCalls, hasLength(1));
    expect(methodCalls.single.method, 'updateConfig');

    final arguments = methodCalls.single.arguments as Map<Object?, Object?>;
    expect(arguments['iosLockWithDidEnterBackground'], isFalse);
    expect(arguments['privacyImageName'], 'LaunchImage');
    expect(arguments['blurEffect'], 'dark');
    expect(arguments['backgroundColor'], '#445566');
    expect(arguments['backgroundOpacity'], closeTo(0.4, 0.001));
    expect(arguments['enablePrivacyIos'], isTrue);
    expect(arguments['autoLockAfterSecondsIos'], 5);
    expect(arguments['enableSecureAndroid'], isFalse);
    expect(arguments['autoLockAfterSecondsAndroid'], 10);
  });
}
