import 'package:flutter_test/flutter_test.dart';
import 'package:jameya_admin/core/services/services_locator.dart';
import 'package:jameya_admin/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await setupServiceLocator();
  });

  testWidgets('App builds and shows splash', (WidgetTester tester) async {
    await tester.pumpWidget(const Jameya());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(Jameya), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
