import 'package:flutter/material.dart';
import 'package:test_maha_dev/presentation/screen/home.dart';
import 'package:test_maha_dev/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Flutter Dev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const HomeScreen(),
      routes: routes,
      initialRoute: HomeScreen.routeName,
    );
  }
}
