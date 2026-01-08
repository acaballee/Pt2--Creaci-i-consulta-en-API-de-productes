import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:first_flutter/data/models/sentence.dart';

abstract class ISentenceService {
Sentence getNext() ;
}
class SentenceService implements ISentenceService {
@override
 Sentence getNext() {
    return Sentence(text: WordPair.random().asString);
  }
}


// New implementation of ISentenceService
class AnotherSentenceService implements ISentenceService {
  // 1. Definim les llistes "hardcoded" com a atributs de la classe
  final List<String> _subjectes = [
    'El programador',
    'La gata',
    'El meu amic',
    'Un robot',
    'La professora'
  ];

  final List<String> _verbs = [
    'compila',
    'mira',
    'escriu',
    'troba',
    'depura'
  ];

  final List<String> _objectes = [
    'el codi.',
    'una finestra.',
    'l\'error.',
    'una base de dades.',
    'el teclat.'
  ];

  // Instància per generar nombres aleatoris
  final Random _random = Random();

  @override
  Sentence getNext() {
    // 2. Triem un índex aleatori per a cada llista
    // nextInt(n) retorna un valor entre 0 i n-1
    String subjecte = _subjectes[_random.nextInt(_subjectes.length)];
    String verb = _verbs[_random.nextInt(_verbs.length)];
    String objecte = _objectes[_random.nextInt(_objectes.length)];

    // 3. Retornem la nova Sentence concatenant les parts
    return Sentence(text: "$subjecte $verb $objecte");
  }
}