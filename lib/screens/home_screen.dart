import 'package:flutter/material.dart';
import '../data/product_repository.dart';
import '../models/product.dart';
import '../state/cart_model.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Product>> _future;
  String _category = 'Tümü';
  String _sort = 'Önerilen';
  String _query = '';

  static const _sorts = ['Önerilen', 'Fiyat (artan)', 'Fiyat (azalan)', 'Puan'];

  @override
  void initState() {
    super.initState();
    _future = loadProducts();
  }

  List<Product> _filter(List<Product> all) {
    final list = all.where((p) {
      final matchCat = _category == 'Tümü' || p.category == _category;
      final q = _query.toLowerCase();
      final matchQuery = q.isEmpty ||
          p.title.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q);
      return matchCat && matchQuery;
    }).toList();
    switch (_sort) {
      case 'Fiyat (artan)':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Fiyat (azalan)':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Puan':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError || snap.data == null) {
              return Center(child: Text('Veri yüklenemedi: ${snap.error}'));
            }
            final all = snap.data!;
            final categories = ['Tümü', ...{...all.map((p) => p.category)}];
            int count(String c) =>
                c == 'Tümü' ? all.length : all.where((p) => p.category == c).length;
            final products = _filter(all);

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _header()),
                SliverToBoxAdapter(child: _banner()),
                SliverToBoxAdapter(child: _controls()),
                SliverToBoxAdapter(child: _tabs(categories, count)),
                if (products.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(
                          child: Text('Aramanıza uygun ürün bulunamadı.',
                              style: TextStyle(color: AppColors.muted))),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 240,
                        childAspectRatio: 0.78,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => ProductCard(product: products[i]),
                        childCount: products.length,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
      child: Row(children: [
        const SizedBox(width: 48),
        const Expanded(
          child: Column(children: [
            Text('🛍️  Mini Katalog',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text)),
            SizedBox(height: 4),
            Text('Flutter ile geliştirildi. Veriler JSON dosyasından alınır.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 12)),
          ]),
        ),
        AnimatedBuilder(
          animation: cart,
          builder: (context, _) => IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: Badge(
              isLabelVisible: cart.totalCount > 0,
              label: Text('${cart.totalCount}'),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.shopping_cart_outlined,
                  color: AppColors.text),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _banner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(children: [
          Image.asset('assets/images/banner.png',
              height: 130, width: double.infinity, fit: BoxFit.cover),
          const Positioned(
            left: 20,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Yeni Sezon Fırsatları',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 4),
                Text('Seçili ürünlerde kaçırılmayacak fiyatlar',
                    style: TextStyle(color: Color(0xE6FFFFFF), fontSize: 12)),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _controls() {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border));
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(children: [
        Expanded(
          child: TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Ürünlerde ara...',
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: border,
              enabledBorder: border,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _sort,
              style: const TextStyle(color: AppColors.text, fontSize: 13),
              items: _sorts
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _sort = v!),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _tabs(List<String> categories, int Function(String) count) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: AppColors.border, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: categories.map((c) {
            final selected = c == _category;
            return GestureDetector(
              onTap: () => setState(() => _category = c),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: selected
                      ? const [
                          BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 4,
                              offset: Offset(0, 1))
                        ]
                      : null,
                ),
                child: Text('$c (${count(c)})',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color:
                            selected ? AppColors.primaryDark : AppColors.muted)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
