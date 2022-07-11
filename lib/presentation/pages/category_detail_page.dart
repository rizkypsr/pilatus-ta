import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/presentation/pages/product_detail_page.dart';
import 'package:pilatus/presentation/provider/product_by_category_notifier.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';
import 'package:provider/provider.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({Key? key, required this.categoryId})
      : super(key: key);

  final int categoryId;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductByCategoryNotifier>(context, listen: false)
          ..fetchProducts(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kategori',
          style: heading6.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Consumer<ProductByCategoryNotifier>(builder: (context, data, _) {
          final state = data.productsState;
          if (state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ListView.builder(
              itemCount: data.products.length,
              itemBuilder: (context, index) {
                return ProductListItem(
                  product: data.products[index],
                );
              },
            );
          } else if (state == RequestState.Error) {
            return Center(child: Text(data.message));
          } else {
            return const Center(child: Text('Tidak ada produk'));
          }
        }),
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      height: 120,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product)));
        },
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: '$baseUrl/storage/products/${product.photo}',
              width: 70,
              fadeOutDuration: const Duration(milliseconds: 0),
              fadeInDuration: const Duration(milliseconds: 0),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => BlurHash(hash: product.blurhash!),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Produk 1',
                  style: heading6.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Weight: 1.2',
                  style: paragraph2.copyWith(
                    color: secondaryLightColor.withOpacity(.60),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  CurrencyFormat.convertToIdr(35900, 0),
                  style: heading3.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
