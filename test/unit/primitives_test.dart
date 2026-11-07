import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiny_court/intl/i18n.dart';
import 'package:tiny_court/model/enums/verdict_type.dart';
import 'package:tiny_court/ui/tokens/tokens.dart';
import 'package:tiny_court/views/widgets/ds/ds.dart';

Widget _wrapWithLocalizations(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppStringsDelegate.delegates,
    supportedLocales: AppStringsDelegate.appSupportedLocales,
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Atomic DS Primitives Tests', () {
    testWidgets('AppText renders text with given style and custom color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapWithLocalizations(
          const AppText(
            'Order in the Court!',
            style: AppTextStyle.headlineLarge,
            color: Color(0xFFE6B042),
          ),
        ),
      );

      expect(find.text('Order in the Court!'), findsOneWidget);
      final Text textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontSize, 28.0);
      expect(textWidget.style?.color, const Color(0xFFE6B042));
    });

    testWidgets('AppButton handles tap and displays loading state',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        _wrapWithLocalizations(
          AppButton(
            label: 'Strike Gavel',
            onPressed: () => tapped = true,
          ),
        ),
      );

      expect(find.text('Strike Gavel'), findsOneWidget);
      await tester.tap(find.text('Strike Gavel'));
      expect(tapped, isTrue);

      // Verify loading state disables button and shows spinner
      await tester.pumpWidget(
        _wrapWithLocalizations(
          AppButton(
            label: 'Strike Gavel',
            isLoading: true,
            onPressed: () => tapped = false,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('ParchmentCard renders child and triggers tap callback',
        (WidgetTester tester) async {
      bool cardTapped = false;

      await tester.pumpWidget(
        _wrapWithLocalizations(
          ParchmentCard(
            onTap: () => cardTapped = true,
            child: const Text('Evidence A'),
          ),
        ),
      );

      expect(find.text('Evidence A'), findsOneWidget);
      await tester.tap(find.text('Evidence A'));
      expect(cardTapped, isTrue);
    });

    testWidgets('LegalBadge renders label with icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapWithLocalizations(
          const LegalBadge(
            label: 'Food Crime',
            icon: Icons.fastfood,
          ),
        ),
      );

      expect(find.text('Food Crime'), findsOneWidget);
      expect(find.byIcon(Icons.fastfood), findsOneWidget);
    });

    testWidgets('CourtDivider renders plain and with gavel icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapWithLocalizations(
          const Column(
            children: [
              CourtDivider(hasGavelIcon: false),
              CourtDivider(hasGavelIcon: true),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.gavel), findsOneWidget);
    });

    testWidgets('JudgeMascotView renders expressions and dialogue bubble',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapWithLocalizations(
          const JudgeMascotView(
            expression: JudgeExpression.stern,
            dialogueBubble: 'Silence in my courtroom!',
          ),
        ),
      );

      expect(find.text('Silence in my courtroom!'), findsOneWidget);
      expect(find.byIcon(Icons.sentiment_very_dissatisfied), findsOneWidget);
    });

    testWidgets('GavelStrikeAction performs rotation and executes onStrike',
        (WidgetTester tester) async {
      bool struck = false;

      await tester.pumpWidget(
        _wrapWithLocalizations(
          GavelStrikeAction(
            label: 'Tap Gavel',
            onStrike: () => struck = true,
          ),
        ),
      );

      expect(find.text('Tap Gavel'), findsOneWidget);
      await tester.tap(find.byType(GavelStrikeAction));
      await tester.pumpAndSettle();

      expect(struck, isTrue);
    });

    testWidgets('VerdictStamp renders correct text and color for verdict types',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapWithLocalizations(
          const Column(
            children: [
              VerdictStamp(
                verdictType: VerdictType.guiltyDefendant,
                isAnimated: false,
              ),
              VerdictStamp(
                verdictType: VerdictType.notGuilty,
                isAnimated: false,
              ),
            ],
          ),
        ),
      );

      expect(find.text('GUILTY'), findsOneWidget);
      expect(find.text('NOT GUILTY'), findsOneWidget);
    });

    testWidgets('ArgumentScrollCard renders both plaintiff and defendant sides',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapWithLocalizations(
          const ArgumentScrollCard(
            plaintiffName: 'Alice',
            plaintiffArgument: 'He ate my clearly labeled sandwich!',
            defendantName: 'Bob',
            defendantArgument: 'It had been in the fridge for 3 days!',
          ),
        ),
      );

      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('He ate my clearly labeled sandwich!'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
      expect(find.text('It had been in the fridge for 3 days!'), findsOneWidget);
    });
  });
}
