import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingInternal extends StatelessWidget {
  final Color color;
  final bool loading;
  final double? size;

  const LoadingInternal({
    super.key,
    required this.color,
    this.loading = false,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: loading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: color,
                  size: 40,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
