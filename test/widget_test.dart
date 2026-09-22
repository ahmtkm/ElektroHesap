import 'package:elektro_hesap/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ElektroHesap ana ekranı açılır', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('ElektroHesap'), findsOneWidget);
    expect(find.text('⚡ Kablo Kesit Hesabı'), findsOneWidget);
    expect(find.text('📉 Gerilim Düşümü'), findsOneWidget);
    expect(find.text('🔌 Sigorta Seçimi'), findsOneWidget);
  });
}
