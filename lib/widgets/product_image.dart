import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProductImage extends StatelessWidget {
  final String path;
  final BoxFit fit;
  const ProductImage(this.path, {super.key, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      errorBuilder: (context, error, stack) => Container(
        color: AppColors.primarySoft,
        child: const Center(
            child: Icon(Icons.image_not_supported_outlined,
                color: AppColors.primary)),
      ),
    );
  }
}
