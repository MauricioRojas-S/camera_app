// lib/main.dart
import 'package:flutter/material.dart';
import 'presentation/pages/camera_page.dart';
void main() {

WidgetsFlutterBinding.ensureInitialized();
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
const MyApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Flutter Camera App',
theme: ThemeData(
primarySwatch: Colors.blue,
visualDensity: VisualDensity.adaptivePlatformDensity,
),
home: const CameraPage(),
);
}
}