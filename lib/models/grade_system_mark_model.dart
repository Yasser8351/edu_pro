class GradeSystemMarkModel {
  double? maximum;
  double? minimum;
  String? classificationName;

  GradeSystemMarkModel({
    required this.classificationName,
    required this.maximum,
    required this.minimum,
  });

  factory GradeSystemMarkModel.fromJson(Map<String, dynamic> jsonData) {
    return GradeSystemMarkModel(
        classificationName: jsonData['classificationName'],
        maximum:
            jsonData['maximum'] == null ? 0.0 : jsonData['maximum'].toDouble(),
        minimum:
            jsonData['minimum'] == null ? 0.0 : jsonData['minimum'].toDouble());
  }
}

class gradeSystemMarkList {
  final List<dynamic> listgradeSystemMark;
  gradeSystemMarkList({required this.listgradeSystemMark});
  factory gradeSystemMarkList.fromJson(Map<String, dynamic> jsonData) {
    return gradeSystemMarkList(
      listgradeSystemMark: jsonData['gradeSystemMark'],
    );
  }
}
/*
  "gradeSystemMark": [
        {
            "classificationName": "Excellent",
            "gradeSystemClassificationId": 30,
            "gradeSystemNo": 20,
            "classificationTypeNo": 1,
           
            "classificationNameAr": "ex"
        },
*/