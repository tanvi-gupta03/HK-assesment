import 'package:assesment/productform/form.dart';
import 'package:assesment/screens/home.dart';
import 'package:assesment/screens/login.dart';
import 'package:assesment/productform/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: loginpage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

