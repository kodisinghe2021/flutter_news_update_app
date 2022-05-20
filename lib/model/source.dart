class Source {
  // variables
  String? id;
  String? name;
  // constructor
  Source({this.id, this.name});

  // mapping jason to variables
  factory Source.fromJason(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}
