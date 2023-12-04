import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:moonbase_explore/model/video_model.dart';



class Unit {
  final String id;
  final int unitNumber;
  final String title;
  final String description;
  final List<Video> videos;
  Unit({
    required this.id,
    required this.unitNumber,
    required this.title,
    required this.description,
    required this.videos,
  });

  Unit copyWith({
    String? id,
    int? unitNumber,
    String? title,
    String? description,
    List<Video>? videos,
  }) {
    return Unit(
      id: id ?? this.id,
      unitNumber: unitNumber ?? this.unitNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      videos: videos ?? this.videos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unitNumber': unitNumber,
      'title': title.trim(),
      'description': description.trim(),
      'videos': videos.map((x) => x.toMap()).toList(),
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'] ?? '',
      unitNumber: int.tryParse(map['unitNumber'].toString()) ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      videos: List<Video>.from(map['videos']?.map((x) => Video.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Unit(id: $id, unitNumber: $unitNumber, title: $title, description: $description, videos: $videos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Unit &&
        other.id == id &&
        other.unitNumber == unitNumber &&
        other.title == title &&
        other.description == description &&
        listEquals(other.videos, videos);
  }

  @override
  int get hashCode {
    return id.hashCode ^ unitNumber.hashCode ^ title.hashCode ^ description.hashCode ^ videos.hashCode;
  }
}
