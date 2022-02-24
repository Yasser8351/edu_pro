import 'package:flutter/material.dart';

class ConnectionStatuesBars extends StatelessWidget {
  ConnectionStatuesBars({
    Key? key,
  }) : super(key: key);
  ////late Function retry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off,
          size: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(height: 20),
        Text(
          "No Internet found, Check your connection",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
