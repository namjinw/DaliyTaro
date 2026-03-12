import 'package:dailytaro/page/daily_flow.dart';
import 'package:dailytaro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: nanum),
      home: DailyFlowPage(),
    );
  }
}
