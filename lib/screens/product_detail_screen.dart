import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart_model.dart';
import '../theme/app_theme.dart';
import '../widgets/product_image.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
        actions: [
          AnimatedBuilder(
            animation: cart,
            builder: (context, _) => IconButton(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              icon: Badge(
                isLabelVisible: cart.totalCount > 0,
                label: Text('${cart.totalCount}'),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: AspectRatio(
                        aspectRatio: 16 / 10, child: ProductImage(product.image)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(spacing: 8, runSpacing: 6, children: [
                          Pill(product.category, icon: Icons.sell_outlined),
                          Pill(
                            product.inStock
                                ? 'Stokta: ${product.stock}'
                                : 'Tükendi',
                            background: product.inStock
                                ? AppColors.successSoft
                                : AppColors.dangerSoft,
                            foreground: product.inStock
                                ? AppColors.success
                                : AppColors.dangerDark,
                          ),
                          Pill('★ ${product.rating}',
                              background: const Color(0xFFFEF3C7),
                              foreground: const Color(0xFFB45309)),
                        ]),
                        const SizedBox(height: 14),
                        Text(product.title,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.text)),
                        const SizedBox(height: 6),
                        Text(product.priceText,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary)),
                        const SizedBox(height: 14),
                        Text(product.description,
                            style: const TextStyle(
                                color: AppColors.muted, height: 1.5)),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: product.inStock
                                ? () {
                                    cart.add(product);
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(const SnackBar(
                                          content: Text('Sepete eklendi'),
                                          duration: Duration(seconds: 1)));
                                  }
                                : null,
                            icon: const Icon(Icons.add_shopping_cart),
                            label: Text(
                                product.inStock ? 'Sepete Ekle' : 'Stokta Yok'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
