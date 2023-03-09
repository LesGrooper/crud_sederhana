// import 'dart:convert';

// ComicModel comicModelFromJson(String str) =>
//     ComicModel.fromJson(json.decode(str));

// String comicModelToJson(ComicModel data) => json.encode(data.toJson());

class ComicModel {
  ComicModel({
    required this.data,
    required this.meta,
  });

  List<Comic> data;
  Meta meta;

  factory ComicModel.fromJson(Map<String, dynamic> json) => ComicModel(
        data: List<Comic>.from(json["data"].map((x) => Comic.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Comic {
  Comic({
    required this.id,
    required this.attributes,
  });

  int id;
  Attributes attributes;

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    required this.judul,
    required this.stock,
    required this.tanggalMasuk,
    required this.harga,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  String judul;
  dynamic stock;
  DateTime tanggalMasuk;
  dynamic harga;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        judul: json["Judul"],
        stock: json["Stock"],
        tanggalMasuk: DateTime.parse(json["Tanggal_Masuk"]),
        harga: json["Harga"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "Judul": judul,
        "Stock": stock,
        "Tanggal_Masuk":
            "${tanggalMasuk.year.toString().padLeft(4, '0')}-${tanggalMasuk.month.toString().padLeft(2, '0')}-${tanggalMasuk.day.toString().padLeft(2, '0')}",
        "Harga": harga,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  int page;
  int pageSize;
  int pageCount;
  int total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}
