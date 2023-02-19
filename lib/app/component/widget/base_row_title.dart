import 'package:flutter/material.dart';

class BaseRowTitle extends StatelessWidget {
  const BaseRowTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
