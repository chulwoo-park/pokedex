import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class OverScrollBackdrop extends StatefulWidget {
  const OverScrollBackdrop({
    required this.topColor,
    required this.bottomColor,
    this.backgroundColor,
    this.child,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  });

  final Color topColor;
  final Color bottomColor;
  final Color? backgroundColor;
  final Widget? child;

  final ScrollNotificationPredicate notificationPredicate;

  @override
  _OverScrollBackdropState createState() => _OverScrollBackdropState();
}

class _OverScrollBackdropState extends State<OverScrollBackdrop> {
  late ValueNotifier<double> _topHeightNotifier;
  late ValueNotifier<double> _bottomHeightNotifier;
  late ValueNotifier<double> _backgroundTopNotifier;
  late ValueNotifier<double> _backgroundBottomNotifier;

  @override
  void initState() {
    super.initState();
    _topHeightNotifier = ValueNotifier(0);
    _bottomHeightNotifier = ValueNotifier(0);
    _backgroundTopNotifier = ValueNotifier(0);
    _backgroundBottomNotifier = ValueNotifier(0);
  }

  @override
  void didUpdateWidget(OverScrollBackdrop oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.child != widget.child ||
        oldWidget.topColor != widget.topColor ||
        oldWidget.bottomColor != widget.bottomColor ||
        oldWidget.backgroundColor != widget.backgroundColor) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return NotificationListener<ScrollUpdateNotification>(
          onNotification: (scroll) =>
              _handleScrollNotification(constraints, scroll),
          child: Stack(
            children: [
              if (widget.backgroundColor != null)
                ValueListenableBuilder(
                  valueListenable: _backgroundTopNotifier,
                  builder: (context, topOffset, child) =>
                      ValueListenableBuilder(
                    valueListenable: _backgroundBottomNotifier,
                    builder: (context, bottomOffset, child) => Positioned.fill(
                      child: Container(
                        constraints: constraints,
                        color: widget.backgroundColor,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: ValueListenableBuilder<double>(
                  valueListenable: _topHeightNotifier,
                  builder: (context, height, child) => Container(
                    height: min(height, constraints.maxHeight),
                    color: widget.topColor,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ValueListenableBuilder<double>(
                  valueListenable: _bottomHeightNotifier,
                  builder: (context, height, child) => Container(
                    height: min(height, constraints.maxHeight),
                    color: widget.bottomColor,
                  ),
                ),
              ),
              if (widget.child != null) widget.child!,
            ],
          ),
        );
      },
    );
  }

  bool _handleScrollNotification(
    BoxConstraints constraints,
    ScrollUpdateNotification scroll,
  ) {
    if (!widget.notificationPredicate(scroll)) return false;
    if (scroll.metrics.pixels <= 0) {
      _topHeightNotifier.value = scroll.metrics.pixels.abs() + 1;
    } else if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent) {
      _bottomHeightNotifier.value =
          (scroll.metrics.pixels - scroll.metrics.maxScrollExtent) + 1;
    }

    if (widget.backgroundColor != null) {
      final backgroundTop = max(0.0, -scroll.metrics.pixels);

      if (_backgroundTopNotifier.value != backgroundTop) {
        _backgroundTopNotifier.value = backgroundTop;
      }

      final backgroundBottom =
          max(0.0, -(scroll.metrics.pixels - scroll.metrics.maxScrollExtent));
      if (_backgroundBottomNotifier.value != backgroundBottom) {
        _backgroundBottomNotifier.value = backgroundBottom;
      }
    }

    return false;
  }

  @override
  void dispose() {
    _bottomHeightNotifier.dispose();
    _topHeightNotifier.dispose();
    super.dispose();
  }
}
