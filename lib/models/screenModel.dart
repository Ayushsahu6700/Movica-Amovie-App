// To parse this JSON data, do
//
//     final screenModel = screenModelFromJson(jsonString);

import 'dart:convert';

ScreenModel screenModelFromJson(Map<String, dynamic> json) =>
    ScreenModel.fromJson(json);

String screenModelToJson(ScreenModel data) => json.encode(data.toJson());

class ScreenModel {
  ScreenModel({
    this.id,
    this.backdrops,
    this.posters,
  });

  int? id;
  List<Backdrop>? backdrops;
  List<Backdrop>? posters;

  factory ScreenModel.fromJson(Map<String, dynamic> json) => ScreenModel(
        id: json["id"] == null ? null : json["id"],
        backdrops: json["backdrops"] == null
            ? null
            : List<Backdrop>.from(
                json["backdrops"].map((x) => Backdrop.fromJson(x))),
        posters: json["posters"] == null
            ? null
            : List<Backdrop>.from(
                json["posters"].map((x) => Backdrop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "backdrops": backdrops == null
            ? null
            : List<dynamic>.from(backdrops!.map((x) => x.toJson())),
        "posters": posters == null
            ? null
            : List<dynamic>.from(posters!.map((x) => x.toJson())),
      };
}

class Backdrop {
  Backdrop({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  double? aspectRatio;
  String? filePath;
  int? height;
  String? iso6391;
  int? voteAverage;
  int? voteCount;
  int? width;

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
        aspectRatio: json["aspect_ratio"] == null
            ? null
            : json["aspect_ratio"].toDouble(),
        filePath: json["file_path"] == null ? null : json["file_path"],
        height: json["height"] == null ? null : json["height"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        voteAverage: json["vote_average"] == null ? null : json["vote_average"],
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio == null ? null : aspectRatio,
        "file_path": filePath == null ? null : filePath,
        "height": height == null ? null : height,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
        "width": width == null ? null : width,
      };
}
