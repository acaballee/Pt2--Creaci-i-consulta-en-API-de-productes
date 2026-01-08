import 'dart:collection';

import 'package:first_flutter/data/models/sentence.dart';
import 'package:first_flutter/data/repositories/sentence_repository.dart';
import 'package:flutter/material.dart';

class SentenceVM extends ChangeNotifier {
 final ISentenceRepository _sentenceRepository;
 SentenceVM({required ISentenceRepository sentenceRepository}) 
  : _sentenceRepository = sentenceRepository {

 _current = _sentenceRepository.current;
 }


late Sentence _current;


 // Getters
 Sentence get current => _current;
 UnmodifiableListView<Sentence> get history => UnmodifiableListView(_sentenceRepository.history);
 UnmodifiableListView<Sentence> get favorites => UnmodifiableListView(_sentenceRepository.favorites);
void next()  {
    _current = _sentenceRepository.getNext();
    notifyListeners();
 }

void toggleFavorite(Sentence pair) {
    _sentenceRepository.toggleFavorite(pair);
    notifyListeners();
  }
 
 bool isFavorite(Sentence pair) {
    return _sentenceRepository.isFavorite(pair);
  }
   void toggleCurrentFavorite() {
    toggleFavorite(_current);
  }
}