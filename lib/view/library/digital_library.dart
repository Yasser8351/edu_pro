import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/library/books_book.dart';
import 'package:edu_pro/view/library/library.dart';
import 'package:edu_pro/view_models/library/books_view_model.dart';
import 'package:edu_pro/view_models/library/publications_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import 'publications_book.dart';

class DigitalLibrary extends StatefulWidget {
  const DigitalLibrary({Key? key}) : super(key: key);
  static const routeName = 'DigitalLibrary';

  @override
  State<DigitalLibrary> createState() => _DigetialLibraryState();
}

class _DigetialLibraryState extends State<DigitalLibrary> {
  int? _value = 1;
  Future? _dataPublications, _dataBooks;
  final _form = GlobalKey<FormState>();
  var api = Api();

  final _titleController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var publicationslist =
        Provider.of<PublicationsViewModel>(context, listen: false)
            .PublicationsList;

    var bookList =
        Provider.of<BooksViewModel>(context, listen: false).BooksList;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Library.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Digital Library',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          print(connected);
        },
        connected: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Search for :',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Row(
                        children: [
                          Radio<int>(
                              value: 1,
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              }),
                          Text(
                            'Publications',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<int>(
                              value: 2,
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              }),
                          Text(
                            'Books',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          textAlign: TextAlign.left,
                          controller: _titleController,
                          decoration: InputDecoration(
                              labelText: _value == 1
                                  ? "Publications Name"
                                  : "Book Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              )),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              //"Publications Name":
                              return _value == 1
                                  ? 'Please Enter the Publications Name'
                                  : 'Please Enter the Book title';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.blue,
                        color: Theme.of(context).colorScheme.primary),
                    child: TextButton(
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        final isValid = _form.currentState!.validate();
                        if (!isValid) {
                          return null;
                        }
                        _form.currentState!.save();
                        if (_value == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PublicationsBook(
                                  bookTitle: _titleController.text)));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  BooksBook(bookTitle: _titleController.text)));
                        }
                      },
                    ),
                  ),
                ],
              )),
        ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
