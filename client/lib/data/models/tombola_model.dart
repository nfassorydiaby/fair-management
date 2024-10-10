class TombolaModel {
  final int studentId;
  final int tickets;

  TombolaModel({required this.studentId, required this.tickets});

  factory TombolaModel.fromJson(Map<String, dynamic> json) {
    return TombolaModel(
      studentId: json['student_id'],
      tickets: json['tickets'],
    );
  }
}
