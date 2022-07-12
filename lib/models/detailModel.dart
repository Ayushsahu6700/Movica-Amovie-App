// To parse this JSON data, do
//
//     final detailModel = detailModelFromJson(jsonString);

import 'dart:convert';

DetailModel detailModelFromJson(Map<String, dynamic> json) =>
    DetailModel.fromJson(json);

String detailModelToJson(DetailModel data) => json.encode(data.toJson());

class DetailModel {
  DetailModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  DateTime? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"] == null
            ? null
            : BelongsToCollection.fromJson(json["belongs_to_collection"]),
        budget: json["budget"] == null ? null : json["budget"],
        genres: json["genres"] == null
            ? null
            : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"] == null ? null : json["homepage"],
        id: json["id"] == null ? null : json["id"],
        imdbId: json["imdb_id"] == null ? null : json["imdb_id"],
        originalLanguage: json["original_language"] == null
            ? null
            : json["original_language"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        overview: json["overview"] == null ? null : json["overview"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        productionCompanies: json["production_companies"] == null
            ? null
            : List<ProductionCompany>.from(json["production_companies"]
                .map((x) => ProductionCompany.fromJson(x))),
        productionCountries: json["production_countries"] == null
            ? null
            : List<ProductionCountry>.from(json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        revenue: json["revenue"] == null ? null : json["revenue"],
        runtime: json["runtime"] == null ? null : json["runtime"],
        spokenLanguages: json["spoken_languages"] == null
            ? null
            : List<SpokenLanguage>.from(json["spoken_languages"]
                .map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
        tagline: json["tagline"] == null ? null : json["tagline"],
        title: json["title"] == null ? null : json["title"],
        video: json["video"] == null ? null : json["video"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "belongs_to_collection":
            belongsToCollection == null ? null : belongsToCollection!.toJson(),
        "budget": budget == null ? null : budget,
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "homepage": homepage == null ? null : homepage,
        "id": id == null ? null : id,
        "imdb_id": imdbId == null ? null : imdbId,
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_title": originalTitle == null ? null : originalTitle,
        "overview": overview == null ? null : overview,
        "popularity": popularity == null ? null : popularity,
        "poster_path": posterPath == null ? null : posterPath,
        "production_companies": productionCompanies == null
            ? null
            : List<dynamic>.from(productionCompanies!.map((x) => x.toJson())),
        "production_countries": productionCountries == null
            ? null
            : List<dynamic>.from(productionCountries!.map((x) => x.toJson())),
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "revenue": revenue == null ? null : revenue,
        "runtime": runtime == null ? null : runtime,
        "spoken_languages": spokenLanguages == null
            ? null
            : List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())),
        "status": status == null ? null : status,
        "tagline": tagline == null ? null : tagline,
        "title": title == null ? null : title,
        "video": video == null ? null : video,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
      };
}

class BelongsToCollection {
  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      BelongsToCollection(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "poster_path": posterPath == null ? null : posterPath,
        "backdrop_path": backdropPath == null ? null : backdropPath,
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"] == null ? null : json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        name: json["name"] == null ? null : json["name"],
        originCountry:
            json["origin_country"] == null ? null : json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "logo_path": logoPath == null ? null : logoPath,
        "name": name == null ? null : name,
        "origin_country": originCountry == null ? null : originCountry,
      };
}

class ProductionCountry {
  ProductionCountry({
    this.iso31661,
    this.name,
  });

  String? iso31661;
  String? name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661 == null ? null : iso31661,
        "name": name == null ? null : name,
      };
}

class SpokenLanguage {
  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  String? englishName;
  String? iso6391;
  String? name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"] == null ? null : json["english_name"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName == null ? null : englishName,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "name": name == null ? null : name,
      };
}
// To parse this JSON data, do
//
//     final detailModel = detailModelFromMap(jsonString);

// import 'dart:convert';
//
// DetailModel detailModelFromMap(String str) => DetailModel.fromMap(json.decode(str));
//
// String detailModelToMap(DetailModel data) => json.encode(data.toMap());

// class DetailModel {
//   DetailModel({
//     this.adult,
//     this.backdropPath,
//     this.belongsToCollection,
//     this.budget,
//     this.genres,
//     this.homepage,
//     this.id,
//     this.imdbId,
//     this.originalLanguage,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.productionCompanies,
//     this.productionCountries,
//     this.releaseDate,
//     this.revenue,
//     this.runtime,
//     this.spokenLanguages,
//     this.status,
//     this.tagline,
//     this.title,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//   });
//
//   bool? adult;
//   String? backdropPath;
//   BelongsToCollection? belongsToCollection;
//   int? budget;
//   List<Genre>? genres;
//   String? homepage;
//   int? id;
//   String? imdbId;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   List<ProductionCompany>? productionCompanies;
//   List<ProductionCountry>? productionCountries;
//   DateTime? releaseDate;
//   int? revenue;
//   int? runtime;
//   List<SpokenLanguage>? spokenLanguages;
//   String? status;
//   String? tagline;
//   String? title;
//   bool? video;
//   double? voteAverage;
//   int? voteCount;
//
//   factory DetailModel.fromMap(Map<String, dynamic> json) => DetailModel(
//     adult: json["adult"] == null ? null : json["adult"],
//     backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
//     belongsToCollection: json["belongs_to_collection"] == null ? null : BelongsToCollection.fromMap(json["belongs_to_collection"]),
//     budget: json["budget"] == null ? null : json["budget"],
//     genres: json["genres"] == null ? null : List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
//     homepage: json["homepage"] == null ? null : json["homepage"],
//     id: json["id"] == null ? null : json["id"],
//     imdbId: json["imdb_id"] == null ? null : json["imdb_id"],
//     originalLanguage: json["original_language"] == null ? null : json["original_language"],
//     originalTitle: json["original_title"] == null ? null : json["original_title"],
//     overview: json["overview"] == null ? null : json["overview"],
//     popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
//     posterPath: json["poster_path"] == null ? null : json["poster_path"],
//     productionCompanies: json["production_companies"] == null ? null : List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromMap(x))),
//     productionCountries: json["production_countries"] == null ? null : List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromMap(x))),
//     releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
//     revenue: json["revenue"] == null ? null : json["revenue"],
//     runtime: json["runtime"] == null ? null : json["runtime"],
//     spokenLanguages: json["spoken_languages"] == null ? null : List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromMap(x))),
//     status: json["status"] == null ? null : json["status"],
//     tagline: json["tagline"] == null ? null : json["tagline"],
//     title: json["title"] == null ? null : json["title"],
//     video: json["video"] == null ? null : json["video"],
//     voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
//     voteCount: json["vote_count"] == null ? null : json["vote_count"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "adult": adult == null ? null : adult,
//     "backdrop_path": backdropPath == null ? null : backdropPath,
//     "belongs_to_collection": belongsToCollection == null ? null : belongsToCollection!.toMap(),
//     "budget": budget == null ? null : budget,
//     "genres": genres == null ? null : List<dynamic>.from(genres!.map((x) => x.toMap())),
//     "homepage": homepage == null ? null : homepage,
//     "id": id == null ? null : id,
//     "imdb_id": imdbId == null ? null : imdbId,
//     "original_language": originalLanguage == null ? null : originalLanguage,
//     "original_title": originalTitle == null ? null : originalTitle,
//     "overview": overview == null ? null : overview,
//     "popularity": popularity == null ? null : popularity,
//     "poster_path": posterPath == null ? null : posterPath,
//     "production_companies": productionCompanies == null ? null : List<dynamic>.from(productionCompanies!.map((x) => x.toMap())),
//     "production_countries": productionCountries == null ? null : List<dynamic>.from(productionCountries!.map((x) => x.toMap())),
//     "release_date": releaseDate == null ? null : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
//     "revenue": revenue == null ? null : revenue,
//     "runtime": runtime == null ? null : runtime,
//     "spoken_languages": spokenLanguages == null ? null : List<dynamic>.from(spokenLanguages!.map((x) => x.toMap())),
//     "status": status == null ? null : status,
//     "tagline": tagline == null ? null : tagline,
//     "title": title == null ? null : title,
//     "video": video == null ? null : video,
//     "vote_average": voteAverage == null ? null : voteAverage,
//     "vote_count": voteCount == null ? null : voteCount,
//   };
// }
//
// class BelongsToCollection {
//   BelongsToCollection({
//     this.id,
//     this.name,
//     this.posterPath,
//     this.backdropPath,
//   });
//
//   int? id;
//   String? name;
//   String? posterPath;
//   String? backdropPath;
//
//   factory BelongsToCollection.fromMap(Map<String, dynamic> json) => BelongsToCollection(
//     id: json["id"] == null ? null : json["id"],
//     name: json["name"] == null ? null : json["name"],
//     posterPath: json["poster_path"] == null ? null : json["poster_path"],
//     backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id == null ? null : id,
//     "name": name == null ? null : name,
//     "poster_path": posterPath == null ? null : posterPath,
//     "backdrop_path": backdropPath == null ? null : backdropPath,
//   };
// }
//
// class Genre {
//   Genre({
//     this.id,
//     this.name,
//   });
//
//   int? id;
//   String? name;
//
//   factory Genre.fromMap(Map<String, dynamic> json) => Genre(
//     id: json["id"] == null ? null : json["id"],
//     name: json["name"] == null ? null : json["name"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id == null ? null : id,
//     "name": name == null ? null : name,
//   };
// }
//
// class ProductionCompany {
//   ProductionCompany({
//     this.id,
//     this.logoPath,
//     this.name,
//     this.originCountry,
//   });
//
//   int? id;
//   String? logoPath;
//   String? name;
//   String? originCountry;
//
//   factory ProductionCompany.fromMap(Map<String, dynamic> json) => ProductionCompany(
//     id: json["id"] == null ? null : json["id"],
//     logoPath: json["logo_path"] == null ? null : json["logo_path"],
//     name: json["name"] == null ? null : json["name"],
//     originCountry: json["origin_country"] == null ? null : json["origin_country"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id == null ? null : id,
//     "logo_path": logoPath == null ? null : logoPath,
//     "name": name == null ? null : name,
//     "origin_country": originCountry == null ? null : originCountry,
//   };
// }
//
// class ProductionCountry {
//   ProductionCountry({
//     this.iso31661,
//     this.name,
//   });
//
//   String? iso31661;
//   String? name;
//
//   factory ProductionCountry.fromMap(Map<String, dynamic> json) => ProductionCountry(
//     iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
//     name: json["name"] == null ? null : json["name"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "iso_3166_1": iso31661 == null ? null : iso31661,
//     "name": name == null ? null : name,
//   };
// }
//
// class SpokenLanguage {
//   SpokenLanguage({
//     this.englishName,
//     this.iso6391,
//     this.name,
//   });
//
//   String? englishName;
//   String? iso6391;
//   String? name;
//
//   factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
//     englishName: json["english_name"] == null ? null : json["english_name"],
//     iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
//     name: json["name"] == null ? null : json["name"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "english_name": englishName == null ? null : englishName,
//     "iso_639_1": iso6391 == null ? null : iso6391,
//     "name": name == null ? null : name,
//   };
// }
