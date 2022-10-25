import 'dart:convert';

class Note {
  int id;
  String note;

  Note({
    required this.id,
    required this.note,
  });

  Note copyWith({
    int? id,
    String? note,
  }) {
    return Note(
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': note,
    };
  }

  factory Note.fromMapp(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      note: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory Note.fromJson(String source) => Note.fromMapp(json.decode());

  @override
  String toString() => 'Note(id:$id, note: $note)';
}
