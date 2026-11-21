import 'package:aero/services/widget_update_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('clearWidgetIfShowing swallows platform errors (iOS without app group)',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('home_widget'), (call) {
      throw PlatformException(code: '-7', message: 'AppGroupId not set');
    });
    await expectLater(
        WidgetUpdateService.clearWidgetIfShowing('f1'), completes);
  });
}
