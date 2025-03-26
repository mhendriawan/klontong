import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String id;
  final String name;
  final String description;
  final int qty;
  final String image;
  final int price;

  Product({
    this.id = "",
    this.name = "",
    this.description = "",
    this.qty = 0,
    this.image = "",
    this.price = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    qty: json["qty"] ?? 0,
    image: json["image"] ?? "",
    price: json["price"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "qty": qty,
    "image": image,
    "price": price,
  };
}
