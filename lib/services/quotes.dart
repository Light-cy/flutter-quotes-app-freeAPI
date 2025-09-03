import 'dart:convert';

Quotes quotesFromJson(String str) => Quotes.fromJson(json.decode(str));

String quotesToJson(Quotes data) => json.encode(data.toJson());

class Quotes {
  int id;
  String quote;
  String author;

  Quotes({required this.id, required this.quote, required this.author});

  factory Quotes.fromJson(Map<String, dynamic> json) =>
      Quotes(id: json["id"], quote: json["quote"], author: json["author"]);

  Map<String, dynamic> toJson() => {"id": id, "quote": quote, "author": author};
}
