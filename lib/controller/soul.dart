import 'dart:convert';
import 'dart:io';

import 'package:dailytarget/model/soul.dart';
import 'package:flutter/services.dart';

class SoulController {
  static DateTime birth = DateTime(DateTime.now().year, 1, 1);
  static String? birthText;
  static List<Soul>? soulCard;
  static List<Soul>? fruitCard;
  static int? selectedNum;
  static List<Soul>? loveCard;
  static int? loveNum;
  static Soul? selectedCard;
  static TarotType type = TarotType.fruit;

  static Future<void> getSoulCardInfo() async {
    final String load = await rootBundle.loadString('assets/data/soul_cards_data.json');

    final List<dynamic> data = jsonDecode(load);

    final list = data.map((e) => Soul.fromJson(e)).toList();
    soulCard = list;
    print(soulCard);
  }

  static void SearchCard(int cardNumber) {
    final card = soulCard!.firstWhere((e) => e.number == cardNumber);
    selectedCard = card;
  }

  static Future<void> getFruitCardInfo() async {
    final String load = await rootBundle.loadString('assets/data/fruit_tarot_cards_data.json');

    final List<dynamic> data = jsonDecode(load);

    final list = data.map((e) => Soul.fromJson(e)).toList();
    fruitCard = list;
    print(fruitCard);
  }

  static Future<void> getLoveCardInfo() async {
    final String load = await rootBundle.loadString('assets/data/loves_tarot_cards_data.json');

    final List<dynamic> data = jsonDecode(load);

    final list = data.map((e) => Soul.fromJson(e)).toList();
    loveCard = list;
    print(loveCard);
  }
}

enum TarotType {
  fruit,
  love
}