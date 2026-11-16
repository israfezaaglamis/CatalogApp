import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart_model.dart';
import '../theme/app_theme.dart';
import '../widgets/product_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: cart,
      builder: (context, _) {
        final items = cart.items;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sepetim'),
            actions: [
              if (items.isNotEmpty)
                TextButton(
                    onPressed: cart.clear,
                    child: const Text('Temizle',
                        style: TextStyle(
                            color: AppColors.danger,
                            fontWeight: FontWeight.w700))),
            ],
          ),
          body: items.isEmpty
              ? const Center(
                  child: Text('Sepetiniz boş 🛒',
                      style: TextStyle(color: AppColors.muted, fontSize: 16)))
              : Column(children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) => _CartTile(item: items[i]),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: AppColors.border))),
                    child: SafeArea(
                      top: false,
                      child: Row(children: [
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Toplam',
                                    style: TextStyle(color: AppColors.muted)),
                                Text(formatPrice(cart.totalPrice),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primary)),
                              ]),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final messenger = ScaffoldMessenger.of(context);
                            cart.clear();
                            Navigator.pop(context);
                            messenger.showSnackBar(const SnackBar(
                                content: Text('Sipariş alındı (simülasyon) ✅')));
                          },
                          child: const Text('Siparişi Tamamla'),
                        ),
                      ]),
                    ),
                  ),
                ]),
        );
      },
    );
  }
}

class _CartTile extends StatelessWidget {
  final CartItem item;
  const _CartTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(width: 64, height: 64, child: ProductImage(p.image)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, color: AppColors.text)),
            const SizedBox(height: 4),
            Pill(p.category),
            const SizedBox(height: 4),
            Text(formatPrice(p.price * item.quantity),
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w800)),
          ]),
        ),
        Row(children: [
          IconButton(
              onPressed: () => cart.decrease(p),
              icon: const Icon(Icons.remove_circle_outline)),
          Text('${item.quantity}',
              style: const TextStyle(fontWeight: FontWeight.w700)),
          IconButton(
              onPressed: () => cart.add(p),
              icon: const Icon(Icons.add_circle_outline)),
        ]),
        IconButton(
            onPressed: () => cart.remove(p),
            icon: const Icon(Icons.delete_outline, color: AppColors.danger)),
      ]),
    );
  }
}
