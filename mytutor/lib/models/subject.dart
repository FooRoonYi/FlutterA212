class Subject {
  String? subjectId;
  String? subjectName;
  String? subjectDescription;
  String? subjectPrice;
  String? tutorId;
  String? subjectSessions;
  String? subjectRatings;

  Subject(
      {this.subjectId,
      this.subjectName,
      this.subjectDescription,
      this.subjectPrice,
      this.tutorId,
      this.subjectSessions,
      this.subjectRatings});

  Subject.fromJson(Map<String, dynamic> json) {
    subjectId = json["sub_id"];
    subjectName = json["sub_name"];
    subjectDescription = json["sub_desc"];
    subjectPrice = json["sub_price"];
    tutorId = json["ttr_id"];
    subjectSessions = json["sub_sessions"];
    subjectRatings = json["sub_ratings"];
  }
}
