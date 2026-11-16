import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart_model.dart';
import '../theme/app_theme.dart';
import 'product_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: SizedBox(
                    width: double.infinity, child: ProductImage(product.image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Pill(product.category, icon: Icons.sell_outlined),
                    const SizedBox(width: 6),
                    if (!product.inStock)
                      const Pill('Tükendi',
                          background: AppColors.dangerSoft,
                          foreground: AppColors.dangerDark),
                  ]),
                  const SizedBox(height: 8),
                  Text(product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                          fontSize: 14)),
                  const SizedBox(height: 6),
                  Row(children: [
                    Expanded(
                      child: Text(product.priceText,
                          style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    ),
                    InkWell(
                      onTap: product.inStock
                          ? () {
                              cart.add(product);
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content:
                                        Text('${product.title} sepete eklendi'),
                                    duration: const Duration(seconds: 1)));
                            }
                          : null,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: product.inStock
                                ? AppColors.primary
                                : AppColors.border,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.add_shopping_cart,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
