import 'package:flutter/material.dart';
class ConditionalWidget extends StatelessWidget {
  final bool? condition;

  final WidgetBuilder? builder;

  final WidgetBuilder? fallback;

  const ConditionalWidget({
    Key? key,
    @required this.condition,
    @required this.builder,
    this.fallback,
}):   assert(condition != null),
      assert(builder != null),
        super(key: key);




  @override
  Widget build(BuildContext context) {
    return condition! ? builder!(context): fallback != null? fallback!(context) : Container();
  }
}
