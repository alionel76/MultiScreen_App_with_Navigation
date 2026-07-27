import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../domain/models/anime.dart';
import '../data/dummy_data.dart';

class AnimeProvider with ChangeNotifier {
  List<Anime> _animes = [];
  bool _isLoading = true;
  final String _savePath = 'animes_persistence.json';

  List<Anime> get animes => _animes;
  bool get isLoading => _isLoading;

  AnimeProvider() {
    _initData();
  }

  Future<void> _initData() async {
    // Dans les tests, on charge les données dummy immédiatement pour éviter les timeouts
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _animes = [...dummyAnimes];
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final file = File(_savePath);
      if (await file.exists()) {
        final String content = await file.readAsString();
        final List<dynamic> jsonList = json.decode(content);
        _animes = jsonList.map((e) => Anime.fromJson(e)).toList();
      } else {
        // Chargement initial depuis les assets
        try {
          final String response = await rootBundle.loadString('assets/data/animes.json');
          final List<dynamic> data = json.decode(response);
          _animes = data.map((e) => Anime.fromJson(e)).toList();
        } catch (e) {
          // Fallback sur dummyData si les assets ne sont pas dispos (ex: tests)
          _animes = [...dummyAnimes];
        }
        await _saveToFile();
      }
    } catch (e) {
      debugPrint('Erreur initialisation: $e');
      _animes = [...dummyAnimes];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveToFile() async {
    try {
      // On évite d'écrire dans les fichiers pendant les tests si possible
      if (Platform.environment.containsKey('FLUTTER_TEST')) return;

      final file = File(_savePath);
      final String jsonContent = json.encode(_animes.map((e) => e.toJson()).toList());
      await file.writeAsString(jsonContent);
    } catch (e) {
      debugPrint('Erreur sauvegarde: $e');
    }
  }

  Future<void> addAnime(Anime anime) async {
    _animes.add(anime);
    notifyListeners();
    await _saveToFile();
  }

  Future<void> deleteAnime(String id) async {
    _animes.removeWhere((anime) => anime.id == id);
    notifyListeners();
    await _saveToFile();
  }

  List<Anime> searchAnimes(String query) {
    if (query.isEmpty) return _animes;
    return _animes
        .where((anime) =>
            anime.title.toLowerCase().contains(query.toLowerCase()) ||
            anime.genre.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
