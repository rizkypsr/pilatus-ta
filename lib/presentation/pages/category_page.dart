import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/category.dart';
import 'package:pilatus/presentation/pages/category_detail_page.dart';
import 'package:pilatus/presentation/provider/category_notifier.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  static List<String> categories = [
    'Kategori 1',
    'Kategori 2',
    'Kategori 3',
  ];

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CategoryNotifier>(context, listen: false)
      ..fetchCategories());
  }

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
        body: Consumer<CategoryNotifier>(builder: (context, data, _) {
          final state = data.categoriesState;

          if (state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state == RequestState.Error) {
            return Center(
              child: Text(data.message),
            );
          }

          if (state == RequestState.Loaded) {
            return Padding(
              padding: const EdgeInsets.all(32),
              child: ListView.builder(
                itemCount: data.categories.length,
                itemBuilder: (context, index) => CategoryListView(
                  category: data.categories[index],
                ),
              ),
            );
          }

          return const SizedBox();
        }));
  }
}

class CategoryListView extends StatelessWidget {
  const CategoryListView({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryDetailPage(categoryId: category.id!),
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
          category.name!,
          style: heading6,
        ),
      ),
    );
  }
}
