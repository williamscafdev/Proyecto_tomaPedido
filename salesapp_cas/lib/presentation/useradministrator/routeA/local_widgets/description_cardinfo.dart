import 'package:flutter/material.dart';
import 'package:salesapp_cas/utils/colors_constants.dart';

class DescriptionRouteCardInfo extends StatelessWidget {
  const DescriptionRouteCardInfo({
    Key? key,
    required this.description,
    required this.route,
  }) : super(key: key);

  final String description;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 50,
        right: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              '$route',
              style: TextStyle(
                fontFamily: 'Oswald',
                color: gray,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
