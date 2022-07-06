import 'package:smarthears_app/models/item.dart';

class Entity extends Item {
  final String id;
  final String name;
  final String logoUrl;
  final String header;

  Entity({required this.id, required this.name, required this.logoUrl, required this.header});

  factory Entity.fromJson(dynamic json) => Entity(id: json['id'], name: json['name'], logoUrl: json['logo'], header: json['header']);
}
