import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/categ/cubit/categories_cubit.dart';
import 'package:task2/categ/widgets/categories_body_view.dart';


class CategoriesProductsScreen extends StatelessWidget {
  const CategoriesProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getAllCategories(),
      child: Scaffold(
          backgroundColor: const Color(0xFFF7F7F9),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: const Text(
              'Store',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: CategoriesBodyView(),
        ),
    );
  }
}
