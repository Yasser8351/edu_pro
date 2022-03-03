class UniversitieyModel {
  int? universitieid;
  String? imageUrl;
  String? universityUrl;
  bool? isActive;

  UniversitieyModel(
      {required this.universitieid,
      required this.imageUrl,
      required this.universityUrl,
      required this.isActive});

  UniversitieyModel.fromJson(Map<String, dynamic> json) {
    universitieid = json['universitieid'] ?? 0;
    imageUrl = json['imageUrl'] ?? "";
    universityUrl = json['universityUrl'] ?? "";
    isActive = json['isActive'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['universitieid'] = this.universitieid;
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
    "university": [
        {
            "universitieid": 1,
            "imageUrl": "C:\\Hash\\umst.png",
            "universityUrl": "http://207.180.223.113:8083/API/",
            "isActive": true
        }
    ]
}
*/