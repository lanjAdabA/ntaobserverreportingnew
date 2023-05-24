import 'package:appntaproject/Pages/signin.page.dart';
import 'package:appntaproject/core/multiprovider.wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiproviderWrapper(
      child: MaterialApp(
          // routes: {
          //   '/loggedin': (context) =>
          //        LoggedInPage(alldata: ),
          //   // Other routes...
          // },
          debugShowCheckedModeBanner: false,
          title: 'NTA Observer Reporting',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
          builder: EasyLoading.init()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SigninPage();
  }
}
