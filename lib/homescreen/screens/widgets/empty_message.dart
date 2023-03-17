import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmptyMesssage extends StatelessWidget {
  const EmptyMesssage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Opacity(
        opacity: 0.6,
        child: EmptyWidget(
          image: 'Assets/images/empty_message.png',
          title: 'No data found',
        ),
      ),
    );
  }
}
