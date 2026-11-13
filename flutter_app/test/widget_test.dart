import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:astroquest/main.dart';

void main() {
  testWidgets('AstroQuest app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const AstroQuestApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
