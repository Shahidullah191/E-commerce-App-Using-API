class CategoryModel {
  int? id;
  String? name;
  String? image;
  String? icon;

  CategoryModel({this.id, this.name, this.image, this.icon});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['icon'] = this.icon;
    return data;
  }
}
