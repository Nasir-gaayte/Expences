import 'package:flutter/material.dart';

import 'widgets/expensese.dart';

var kColorSCHEME = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 5, 99, 125),
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark()
          .copyWith(useMaterial3: true, colorScheme: kDarkColorScheme),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: kColorSCHEME.primary,
          colorScheme: kColorSCHEME,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorSCHEME.onPrimaryContainer,
              foregroundColor: kColorSCHEME.primaryContainer)),
      home: const Expenses(),
      themeMode: ThemeMode.system ,
    );
  }
}
