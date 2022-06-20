import 'package:flutter/material.dart';

class SlidePageRoute<Route> extends MaterialPageRoute<Route> {
  SlidePageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    context,
    Animation<double> animation,
    secondaryAnimation,
    Widget child,
  ) {
    final Animatable<Offset> tween = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
