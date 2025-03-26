import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String id;
  String name;
  String description;
  int qty;
  int price;

  Product({
    this.id = "",
    this.name = "",
    this.description = "",
    this.qty = 0,
    this.price = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    qty: json["qty"] ?? 0,
    price: json["price"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "qty": qty,
    "price": price,
  };
}
