import 'package:flutter_test/flutter_test.dart';

import 'package:trilha_do_atomo/main.dart';

void main() {
  testWidgets('o aplicativo abre', (tester) async {
    await tester.pumpWidget(const TrilhaDoAtomoApp());
    expect(find.text('Trilha do Átomo'), findsOneWidget);
  });
}
