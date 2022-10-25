// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;

  @JsonKey(name: 'title')
  String name;

  @JsonKey(name: 'picture')
  String img;

  String unit;
  double price;
  String description;

  ItemModel({
    this.id = '',
    required this.description,
    required this.img,
    required this.name,
    required this.unit,
    required this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, img: $img, unit: $unit, price: $price, description: $description)';
  }
}
