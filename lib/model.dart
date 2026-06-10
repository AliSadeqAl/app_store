class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final String description;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['title'] ?? '',
      image: json['thumbnail'] ?? '', // مهم جداً DummyJSON
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'thumbnail': image,
      'price': price,
      'description': description,
      'category': category,
    };
  }
}