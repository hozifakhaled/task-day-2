import 'package:flutter/material.dart';
import 'package:task2/core/cache/cache_helper.dart';
import 'package:task2/core/di/service_locator.dart';
import 'package:task2/features/categories/presentation/pages/categoies_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
     CacheHelper().init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CategoriesProductsScreen(),
    );
  }
}
