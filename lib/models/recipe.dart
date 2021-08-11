class Recipe {
  String? id;
  String? name;
  String? category;
  String? ingredients;
  String? photo;

  Recipe({this.id, this.name, this.category, this.ingredients, this.photo});

  Recipe.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id']! as String,
            name: json['name']! as String,
            category: json['category']! as String,
            ingredients: json['ingredients']! as String,
            photo: json['photo']! as String);

  Map<String, Object?> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'category': this.category,
      'ingredients': this.ingredients,
      'photo': this.photo
    };
  }
}
