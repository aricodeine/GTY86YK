import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TextImage {
  String text;
  String imageLink;
  TextImage({
    this.text = '',
    this.imageLink = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'imageLink': imageLink,
    };
  }

  factory TextImage.fromMap(Map<String, dynamic> map) {
    return TextImage(
      text: map['text'] as String,
      imageLink: map['imageLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TextImage.fromJson(String source) =>
      TextImage.fromMap(json.decode(source) as Map<String, dynamic>);
}
