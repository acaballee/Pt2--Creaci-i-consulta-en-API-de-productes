import 'package:first_flutter/data/models/sentence.dart';
import 'package:first_flutter/data/services/sentence_service.dart';

abstract class ISentenceRepository {
  List<Sentence> get history;
  List<Sentence> get favorites;
  Sentence get current;
  Sentence getNext();
  void toggleFavorite(Sentence sentence);
  bool isFavorite(Sentence pair);
}

class SentenceRepository implements ISentenceRepository {
  SentenceRepository({required ISentenceService sentenceService})
    : _sentenceService = sentenceService;
  final ISentenceService _sentenceService;
  late var _current = _sentenceService.getNext();
  List<Sentence> _history = [];
  List<Sentence> _favorites = [];
  // Getters
  @override
  List<Sentence> get history => _history;
  @override
  List<Sentence> get favorites => _favorites;
  @override
  Sentence get current => _current;
  @override
  Sentence getNext() {
    _history.insert(0, _current);
    _current = _sentenceService.getNext();
    return _current;
  }

  @override
  bool isFavorite(Sentence pair) {
    return _favorites.contains(pair);
  }

  @override
  void toggleFavorite(Sentence sentence) {
    if (_favorites.contains(sentence)) {
      _favorites.remove(sentence);
    } else {
      _favorites.add(sentence);
    }
  }
}