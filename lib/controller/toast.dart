import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ToastController {

  static int SelectedMoon = 0;

  static Future<void> toast(String text) async {
    MethodChannel('message').invokeMethod('toast', {'text' : text});
  }
  
  static Future<void> openWeb(String url) async {
    final Uri uri = Uri.parse(url);

    bool success = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!success) {
      toast('링크를 열 수 없습니다!');
    }
  }
}