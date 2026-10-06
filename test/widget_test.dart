import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:localscore/main.dart';

void main() {
  testWidgets('shows tournament list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Turnir 1'), findsOneWidget);
    expect(find.text('Turnir 2'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
