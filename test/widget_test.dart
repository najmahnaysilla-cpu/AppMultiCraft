import 'package:flutter_test/flutter_test.dart';
import 'package:multicraft/main.dart';

void main() {
  testWidgets('MultiCraft menampilkan halaman splash', (WidgetTester tester) async {
    await tester.pumpWidget(const MultiCraftApp());

    expect(find.byType(SplashPage), findsOneWidget);
  });
}