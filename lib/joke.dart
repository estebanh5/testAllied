class Joke {
  final String id;
  final String value;

  Joke({required this.id, required this.value});

  static Joke fromMap(Map<String, dynamic> map) {
    String id = map['id'];
    String value = map['value'];
    return Joke(id: id, value: value);
  }
}
