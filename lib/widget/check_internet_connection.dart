import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        Container(
          width: 120,
          height: 120,
          child: SvgPicture.asset(
            'assets/warning.svg',
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: 40),
        Text(
          "No Internet found, Check your connection",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
