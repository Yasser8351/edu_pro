
class ProfileModel {
  final String? fullName;
  final String? facultyName;
  final String? semesterName;
  final String? specializationName;
  final String? programNameEn;
  final String? batchName;
  final String? bloodGroupName;
  final String? studentIndexNo;
  final String? birthdate;
  final String? gender;
  final String? nationalityName;
  final String? email;
  final String? permenantAddress;
  final String? mobileNum;
  final String? photo;

  ProfileModel({
    this.mobileNum,
    this.photo,
    this.email,
    this.permenantAddress,
    this.bloodGroupName,
    this.studentIndexNo,
    this.birthdate,
    this.gender,
    this.nationalityName,
    this.fullName,
    this.semesterName,
    this.programNameEn,
    this.specializationName,
    this.facultyName,
    this.batchName,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return ProfileModel(
      fullName: jsonData['fullName'],
      semesterName: jsonData['semesterName'],
      programNameEn: jsonData['programNameEn'],
      specializationName: jsonData['specializationName'],
      facultyName: jsonData['facultyName'],
      batchName: jsonData['batchName'],
      birthdate: jsonData['birthdate'],
      bloodGroupName: jsonData['bloodGroupName'],
      gender: jsonData['gender'],
      nationalityName: jsonData['nationalityName'],
      studentIndexNo: jsonData['studentIndexNo'],
      email: jsonData['email'],
      permenantAddress: jsonData['permenantAddress'],
            photo: jsonData['photoImage'],

      mobileNum: jsonData['mobileNum'],


    );
  }
}

class ProfileList {
  final List<dynamic> listProfile;
  ProfileList({required this.listProfile});
  factory ProfileList.fromJson(Map<String, dynamic> jsonData) {
    return ProfileList(
      listProfile: jsonData['profileList'],
    );
  }
}
/*
           "bloodGroupName": null,
            "studentIndexNo": null,
            "birthdate": null,
            "gender": null,
            "nationalityName": null
  
     
    */
