import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/library/books_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksBook extends StatefulWidget {
  const BooksBook({Key? key, this.bookTitle}) : super(key: key);

  final bookTitle;

  @override
  State<BooksBook> createState() => _PublicationsBookState();
}

class _PublicationsBookState extends State<BooksBook> {
  Future? _dataBooks;
  var api = Api();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _dataBooks = Provider.of<BooksViewModel>(context, listen: false)
        .fetchBooks(widget.bookTitle)
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var bookList =
        Provider.of<BooksViewModel>(context, listen: false).BooksList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Digital Library",
          style:
              TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          print(connected);
        },
        connected: bookList == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        'assets/warning.gif',
                        // color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Server error please try again later',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        child: FutureBuilder(
                          future: _dataBooks,
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              if (snapshot.hasError) {
                                return Text("some error");
                              } else if (snapshot.hasData == null) {
                                return Text("No data found");
                              } else if (snapshot.hasData) {
                                return Text("No data found");
                              }
                              return bookList.length == 0
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 150,
                                            child: Image.asset(
                                              'assets/warning.gif',
                                              // color: Colors.blue,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              'No Data Found',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      shadowColor: Colors.grey,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 1),
                                        height:
                                            size.height, //600 size.height / 2.7
                                        child: ListView.builder(
                                          itemCount: bookList.length,
                                          itemBuilder: (ctx, index) => Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "Title",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      trailing: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "${bookList[index].title}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "Publisher",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      trailing: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "${bookList[index].publisher}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "Notes",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      trailing: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "${bookList[index].notes}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "Pages",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      trailing: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "${bookList[index].pages}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "Place",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      trailing: Container(
                                                        width: 213,
                                                        child: Text(
                                                          "${bookList[index].place}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                        height: 60,
                                                        color: Colors.black87)
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ),
                                    );
                            }
                          },
                        ),
                      ),
              ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
  /*
  Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary),
                  child: TextButton(
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    onPressed: () {
                      _isLoading = true;
                      if (_value == 1) {
                        _dataPublications = Provider.of<PublicationsViewModel>(
                                context,
                                listen: false)
                            .fetchPublications()
                            .then((_) => setState(() {
                                  _isLoading = false;
                                }));
                      } else {
                        // _dataBooks =
                        //     Provider.of<BooksViewModel>(context, listen: false)
                        //         .fetchBooks()
                        //         .then((_) => setState(() {
                        //               _isLoading = false;
                        //             }));
                      }
                    },
                  ),
                ),
                _value == 1
                    ? Container(
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox(
                                child: FutureBuilder(
                                  future: _dataPublications,
                                  builder: (_, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      if (snapshot.hasError) {
                                        return Text("some error");
                                      } else if (snapshot.hasData == null) {
                                        return Text("No data found");
                                      } else if (snapshot.hasData) {
                                        return Text("No data found");
                                      }
                                      return bookList.length == 0
                                          ? Text('No Data Found!')
                                          : Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              shadowColor: Colors.grey,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1),
                                                height: 600, //size.height / 2.7
                                                child: ListView.builder(
                                                  itemCount:
                                                      bookList.length,
                                                  itemBuilder: (ctx, index) =>
                                                      Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(5),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "Title",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                              trailing:
                                                                  Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "${bookList[index].title}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title: Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "Publisher",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                              trailing:
                                                                  Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "${bookList[index].publisher}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title: Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "Notes",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                              trailing:
                                                                  Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "${bookList[index].notes}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title: Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "Pages",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                              trailing:
                                                                  Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "${bookList[index].pages}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title: Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "Place",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                              trailing:
                                                                  Container(
                                                                width: 213,
                                                                child: Text(
                                                                  "${bookList[index].place}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                            // place pages
                                                            SizedBox(
                                                                height: 50),
                                                            Divider(height: 5)
                                                          ],
                                                        )
                                                        // child: Column(
                                                        //   children: [
                                                        //     Row(
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment
                                                        //               .start,
                                                        //       children: [
                                                        //         Text(
                                                        //           'Title',
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .black54,
                                                        //               fontSize: 16),
                                                        //         ),
                                                        //         SizedBox(width: 50),
                                                        //         Container(
                                                        //           width: 213,
                                                        //           child: Text(
                                                        //             "${bookList[index].title}",
                                                        //             overflow:
                                                        //                 TextOverflow
                                                        //                     .ellipsis,
                                                        //             maxLines: 10,
                                                        //             style: TextStyle(
                                                        //                 color: Colors
                                                        //                     .black54,
                                                        //                 fontSize:
                                                        //                     16),
                                                        //           ),
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //     SizedBox(height: 30),
                                                        //     Row(
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment
                                                        //               .start,
                                                        //       children: [
                                                        //         Text(
                                                        //           'notes',
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .black54,
                                                        //               fontSize: 16),
                                                        //         ),
                                                        //         SizedBox(width: 50),
                                                        //         Text(
                                                        //           bookList[
                                                        //                           index]
                                                        //                       .notes ==
                                                        //                   null
                                                        //               ? "------"
                                                        //               : "${bookList[index].notes}",
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .black54,
                                                        //               fontSize: 16),
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //     SizedBox(height: 30),
                                                        //     Row(
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment
                                                        //               .start,
                                                        //       children: [
                                                        //         Text(
                                                        //           'publisher',
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .black54,
                                                        //               fontSize: 16),
                                                        //         ),
                                                        //         SizedBox(width: 50),
                                                        //         Container(
                                                        //           width: 105,
                                                        //           child: Text(
                                                        //             bookList[index]
                                                        //                         .publisher ==
                                                        //                     null
                                                        //                 ? "------"
                                                        //                 : "${bookList[index].publisher}",
                                                        //             style: TextStyle(
                                                        //                 color: Colors
                                                        //                     .black54,
                                                        //                 fontSize:
                                                        //                     16),
                                                        //           ),
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //     SizedBox(height: 30),
                                                        //     Row(
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment
                                                        //               .start,
                                                        //       children: [
                                                        //         Text(
                                                        //           'place',
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .black54,
                                                        //               fontSize: 16),
                                                        //         ),
                                                        //         SizedBox(width: 50),
                                                        //         Text(
                                                        //           bookList[
                                                        //                           index]
                                                        //                       .place ==
                                                        //                   null
                                                        //               ? "------"
                                                        //               : "${bookList[index].place}",
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .black54,
                                                        //               fontSize: 16),
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //     SizedBox(height: 30),
                                                        //     Row(
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment
                                                        //               .start,
                                                        //       children: [
                                                        //         Text(
                                                        //           'pages',
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .black54,
                                                        //               fontSize: 16),
                                                        //         ),
                                                        //         SizedBox(width: 50),
                                                        //         Text(
                                                        //           bookList[
                                                        //                           index]
                                                        //                       .pages ==
                                                        //                   null
                                                        //               ? "------"
                                                        //               : "${bookList[index].pages}",
                                                        //           style: TextStyle(
                                                        //               color: Colors
                                                        //                   .black54,
                                                        //               fontSize: 16),
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //     SizedBox(height: 40),
                                                        //     Divider()
                                                        //   ],
                                                        // ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            );
                                    }
                                  },
                                ),
                              ),
                      )
                    : Text(""),
                _value == 2
                    ? Container(
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : FutureBuilder(
                                future: _dataBooks,
                                builder: (_, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    if (snapshot.hasError) {
                                      return Text("some error");
                                    } else if (snapshot.hasData == null) {
                                      return Text("No data found");
                                    } else if (snapshot.hasData) {
                                      return Text("No data found");
                                    }
                                    return bookList.length == 0
                                        ? Text('No Data Found!')
                                        : Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            shadowColor: Colors.grey,
                                            child: Center(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 11),
                                                height: size.height / 3.2,
                                                child: ListView.builder(
                                                  itemCount: bookList.length,
                                                  itemBuilder: (ctx, index) =>
                                                      Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Title',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                  width: 50),
                                                              Text(
                                                                "${bookList[index].title}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 30),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'publisher',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                  width: 50),
                                                              Container(
                                                                width: 170,
                                                                child: Text(
                                                                  "${bookList[index].publisher}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 30),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Authors',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                  width: 50),
                                                              Text(
                                                                bookList[index]
                                                                            .authors ==
                                                                        null
                                                                    ? "-----"
                                                                    : "${bookList[index].authors}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 10,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 30),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'publisher Date',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                  width: 50),
                                                              Text(
                                                                bookList[index]
                                                                            .publisherDate ==
                                                                        null
                                                                    ? "-----"
                                                                    : "${bookList[index].publisherDate}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 10,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                  }
                                },
                              ),
                      )
                    : Text(""),

  */