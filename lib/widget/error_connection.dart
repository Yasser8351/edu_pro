import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                width: 120,
                height: 120,
                child: SvgPicture.asset(
                  'assets/warning.svg',
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
