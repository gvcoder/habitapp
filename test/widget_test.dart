import 'package:flutter_test/flutter_test.dart';

import 'package:habitapp/main.dart';

void main() {
  testWidgets('Aura Login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MyApp(),
    );

    // Verify that the Aura app title is visible on Login.
    expect(find.text('AURA'), findsOneWidget);
    expect(find.text('Connect with Google'), findsOneWidget);
  });
}
