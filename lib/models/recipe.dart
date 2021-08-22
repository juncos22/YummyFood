class Recipe {
  String? id;
  String? name;
  String? type;
  String? category;
  String? ingredients;
  String? preparation;
  String? photo;
  bool isFavorite;

  Recipe(
      {this.id,
      this.name,
      this.type,
      this.category,
      this.ingredients,
      this.preparation,
      this.photo,
      this.isFavorite = false});

  Recipe.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id']! as String,
            name: json['name']! as String,
            type: json['type'] as String,
            category: json['category']! as String,
            ingredients: json['ingredients']! as String,
            preparation: json['preparation']! as String,
            isFavorite: json['isFavorite'] as bool,
            photo: json['photo']! as String);

  Map<String, Object?> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'type': this.type,
      'category': this.category,
      'ingredients': this.ingredients,
      'preparation': this.preparation,
      'isFavorite': this.isFavorite,
      'photo': this.photo
    };
  }
}
