import 'dart:convert';
import 'dart:io';

import 'package:dailytarget/model/soul.dart';
import 'package:flutter/services.dart';

class SoulController {
  static DateTime birth = DateTime(DateTime.now().year, 1, 1);
  static String? birthText;
  static List<Soul>? soulCard;
  static Soul? selectedCard;

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
}