import 'package:flutter/material.dart';

class ErrorConnection extends StatelessWidget {
  const ErrorConnection({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/warning.gif',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.background),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
