class LibraryBorrowModel {
  String? title;
  String? bDate;
  String? dueDate;
  String? returnDate;

  LibraryBorrowModel({this.title, this.bDate, this.dueDate, this.returnDate});

  factory LibraryBorrowModel.fromJson(Map<String, dynamic> json) {
    return LibraryBorrowModel(
      bDate: json['bDate'],
      dueDate: json['dueDate'],
      returnDate: json['returnDate'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['bDate'] = this.bDate;
    data['dueDate'] = this.dueDate;
    data['returnDate'] = this.returnDate;
    return data;
  }
}

class BorrowList {
  final List<dynamic> listBorrow;
  BorrowList({required this.listBorrow});
  factory BorrowList.fromJson(Map<String, dynamic> jsonData) {
    return BorrowList(
      listBorrow: jsonData['libraryBrrowedList'],
    );
  }
}
