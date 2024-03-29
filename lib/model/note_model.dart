class Note {
  int? id;
  String? title;
  String? content;
  String? dateTimeEdited;
  String? dateTimeCreated;

  Note(
      {this.id,
      this.title,
      this.content,
      this.dateTimeCreated,
      this.dateTimeEdited});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'content': this.content,
      'dateTimeCreated': this.dateTimeCreated,
      'dateTimeEdited': this.dateTimeEdited,
    };
  }
}
