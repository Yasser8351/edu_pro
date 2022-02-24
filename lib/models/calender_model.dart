class CalenderModel {
  int? facultyNo;
  int? facultyBatchNo;
  int? calendarTopicId;
  String? topic;
  String? dateFrom;
  String? dateTo;

  CalenderModel(
      {required this.facultyNo,
      required this.facultyBatchNo,
      required this.calendarTopicId,
      required this.dateFrom,
      required this.dateTo});

  CalenderModel.fromJson(Map<String, dynamic> json) {
    facultyNo = json['facultyNo'];
    facultyBatchNo = json['facultyBatchNo'];
    calendarTopicId = json['calendarTopicId'];
    topic = json['topic'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facultyNo'] = this.facultyNo;
    data['facultyBatchNo'] = this.facultyBatchNo;
    data['calendarTopicId'] = this.calendarTopicId;
    data['topic'] = this.topic;
    data['dateFrom'] = this.dateFrom;
    data['dateTo'] = this.dateTo;
    return data;
  }
}

class CalenderList {
  final List<dynamic> listCalender;
  CalenderList({required this.listCalender});
  factory CalenderList.fromJson(Map<String, dynamic> jsonData) {
    return CalenderList(
      listCalender: jsonData['calenders'],
    );
  }
}
