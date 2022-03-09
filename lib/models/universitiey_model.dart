class UniversitieyModel {
  int? universityId;
  String? imageUrl;
  String? universityUrl;
  bool? isActive;

  UniversitieyModel(
      {required this.universityId,
      required this.imageUrl,
      required this.universityUrl,
      required this.isActive});

  UniversitieyModel.fromJson(Map<String, dynamic> json) {
    universityId = json['universityId'] ?? 0;
    imageUrl = json['imageUrl'] ?? "";
    universityUrl = json['universityUrl'] ?? "";
    isActive = json['isActive'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['universityId'] = this.universityId;
    data['imageUrl'] = this.imageUrl;
    data['universityUrl'] = this.universityUrl;
    data['isActive'] = this.isActive;
    return data;
  }
}

class UniversitieyList {
  final List<dynamic> listUniversity;
  UniversitieyList({required this.listUniversity});
  factory UniversitieyList.fromJson(Map<String, dynamic> jsonData) {
    return UniversitieyList(
      listUniversity: jsonData['university'],
    );
  }
}
/*{
    "universityId": 1,
            "universityUrl": "207.180.223.113",
            "imageUrl": "http:",
            "isActive": true
}
*/