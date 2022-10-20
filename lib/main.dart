import 'package:ensam_scanner/pages/scan_page.dart';
import 'package:ensam_scanner/states/scan_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light
      )
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) {
    runApp(
      const App(),
    );
  });

}

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScanState>(create: (_) => ScanState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ENSAM Scanner',
        color: Colors.black,
        initialRoute: '/',
        routes: {
          '/': (context) => ScanPage()
        },
      ),
    );

  }
}