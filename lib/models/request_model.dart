// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestComic {
  final String judul;
  final int stock;
  final DateTime tanggalMasuk;
  final int harga;

  RequestComic(
    this.judul,
    this.stock,
    this.tanggalMasuk,
    this.harga,
  );

  RequestComic copyWith({
    String? judul,
    int? stock,
    DateTime? tanggalMasuk,
    int? harga,
  }) {
    return RequestComic(
      judul ?? this.judul,
      stock ?? this.stock,
      tanggalMasuk ?? this.tanggalMasuk,
      harga ?? this.harga,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'judul': judul,
      'stock': stock,
      'tanggalMasuk': tanggalMasuk.millisecondsSinceEpoch,
      'harga': harga,
    };
  }

  factory RequestComic.fromMap(Map<String, dynamic> map) {
    return RequestComic(
      map['judul'] as String,
      map['stock'] as int,
      DateTime.fromMillisecondsSinceEpoch(map['tanggalMasuk'] as int),
      map['harga'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestComic.fromJson(String source) =>
      RequestComic.fromMap(json.decode(source) as Map<String, dynamic>);
}
