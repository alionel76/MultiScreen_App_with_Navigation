import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiscreen_app_with_navigation/main.dart';
import 'package:multiscreen_app_with_navigation/presentation/widgets/anime_card.dart';

void main() {
  testWidgets('Navigation and Search test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Wait for initial load
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // 1. Verify Home Screen loads
    expect(find.text('Animes World'), findsOneWidget);

    // 2. Test Search functionality
    await tester.enterText(find.byType(TextField), 'One Piece');
    await tester.pumpAndSettle();

    expect(find.text('One Piece'), findsWidgets);
    expect(find.text('Naruto'), findsNothing);

    // 3. Navigation to Details
    // Tap specifically on the AnimeCard to ensure InkWell is hit
    await tester.tap(find.byType(AnimeCard).first);

    // Pump multiple times to handle GoRouter navigation
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify Detail Screen content
    expect(find.text('Synopsis'), findsOneWidget);
    
    // Back to Home
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Animes World'), findsOneWidget);
  });

  testWidgets('Delete Anime test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // 1. Navigate to Details of the first anime (One Piece)
    await tester.tap(find.byType(AnimeCard).first);
    await tester.pumpAndSettle();

    // 2. Tap Delete Icon
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // 3. Verify Confirmation Dialog
    expect(find.text('Confirmer la suppression'), findsOneWidget);

    // 4. Tap Supprimer
    await tester.tap(find.text('Supprimer'));
    await tester.pumpAndSettle();

    // 5. Verify back on Home and Snackbar shown
    expect(find.text('Animes World'), findsOneWidget);
    expect(find.textContaining('a été supprimé'), findsOneWidget);
  });

  testWidgets('Form Validation test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Navigate to Add Form
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('Ajouter un Anime'), findsOneWidget);

    // Try to submit without filling
    await tester.tap(find.text('Enregistrer'));
    await tester.pump();

    // Verify error messages
    expect(find.text('Veuillez entrer un titre'), findsOneWidget);

    // Fill the form
    await tester.enterText(find.widgetWithText(TextFormField, 'Titre'), 'My New Anime');
    await tester.enterText(find.widgetWithText(TextFormField, 'Genre'), 'Sci-Fi');
    await tester.enterText(find.widgetWithText(TextFormField, 'Note (0-10)'), '8.5');
    await tester.enterText(find.widgetWithText(TextFormField, 'Description'), 'A very long description for my new anime.');
    
    await tester.tap(find.text('Enregistrer'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Should be back on Home Screen
    expect(find.text('Animes World'), findsOneWidget);
  });

  testWidgets('Theme toggle test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Go to Settings
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('Paramètres'), findsOneWidget);

    // Find and toggle theme switch
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('Mode Sombre'), findsOneWidget);
  });
}
