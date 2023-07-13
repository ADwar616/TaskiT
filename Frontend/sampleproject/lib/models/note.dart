class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateadded;

  //Default cnstructor of Note
  Note({ this.id, this.userid, this.title, this.content, this.dateadded });

  //factory constructor
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"],
      userid: map["userid"],
      title: map["title"],
      content: map["content"],
      //use tryParse to handle cases with NULL date
      dateadded: DateTime.tryParse(map["dateadded"]),
    );
  }

  //toMap returns a map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "title": title,
      "content": content,
      "dateadded": dateadded!.toIso8601String()
    };
  }
}