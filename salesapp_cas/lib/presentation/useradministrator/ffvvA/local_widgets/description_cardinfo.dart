import 'package:flutter/material.dart';
import 'package:salesapp_cas/utils/colors_constants.dart';

class DescriptionFfvvCardInfo extends StatelessWidget {
  const DescriptionFfvvCardInfo({
    Key? key,
    required this.description,
    required this.ffvv,
  }) : super(key: key);

  final String description;
  final int ffvv;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 70,
        //right: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$description',
              style: TextStyle(
                fontFamily: 'Oswald',
                color: gray,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$ffvv',
              style: TextStyle(
                fontFamily: 'Oswald',
                color: gray,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 2,
              thickness: 2,
            )
          ],
        ));
  }
}
