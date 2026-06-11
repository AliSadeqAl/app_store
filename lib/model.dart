class Product {
  final String id; // تحويل المعرف إلى String ليتوافق مع Document ID في Firestore
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
    required this.category
  });

  // من أجل قراءة مستندات Firestore الحقيقية
  factory Product.fromDoc(Map<String, dynamic> doc, String docId) {
    return Product(
      id: docId,
      name: doc['name'] ?? '',
      image: doc['image'] ?? '',
      price: (doc['price'] as num).toDouble(),
      description: doc['description'] ?? '',
      category: doc['category'] ?? '',
    );
  }

  // من أجل تحويل الكائن إلى Map ورفعه إلى Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'category': category,
    };
  }

  // خاص بالقراءة من ملف الـ JSON المحلي للمفضلة
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }

  // خاص بالحفظ داخل ملف الـ JSON المحلي للمفضلة
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'category': category,
    };
  }
}
