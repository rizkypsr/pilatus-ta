import 'package:flutter/material.dart';
import 'package:pilatus/presentation/pages/category_detail_page.dart';
import 'package:pilatus/styles/text_styles.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  static List<String> categories = [
    'Kategori 1',
    'Kategori 2',
    'Kategori 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Kategori',
            style: heading6.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) => CategoryListView(
              category: categories[index],
            ),
          ),
        ));
  }
}

class CategoryListView extends StatelessWidget {
  const CategoryListView({Key? key, required this.category}) : super(key: key);

  final category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailPage(),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 15),
                blurRadius: 40,
              )
            ]),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        child: Text(
          category,
          style: heading6,
        ),
      ),
    );
  }
}
