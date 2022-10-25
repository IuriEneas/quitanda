import 'package:json_annotation/json_annotation.dart';
import 'package:quitanda/src/models/item_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  CategoryModel({
    required this.id,
    required this.title,
    required this.items,
    required this.pagination,
  });

  String id;
  String title;
  @JsonKey(defaultValue: [])
  List<ItemModel> items;
  @JsonKey(defaultValue: 0)
  int pagination;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return 'CategoryModel(title: $title, id:$id, pagination: $pagination, items: $items)';
  }
}
