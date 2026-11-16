class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  final double rating;
  final int stock;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rating,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        category: json['category'] as String,
        image: json['image'] as String,
        rating: (json['rating'] as num).toDouble(),
        stock: json['stock'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'category': category,
        'image': image,
        'rating': rating,
        'stock': stock,
      };

  String get priceText => formatPrice(price);
  bool get inStock => stock > 0;
}

String formatPrice(double value) =>
    '${value.toStringAsFixed(2).replaceAll('.', ',')} ₺';
