import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  List<CategoryElement> categories;

  Category({
    required this.categories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class CategoryElement {
  String name;
  List<String> subcategory;

  CategoryElement({
    required this.name,
    required this.subcategory,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subcategory": List<dynamic>.from(subcategory.map((x) => x)),
      };
}
