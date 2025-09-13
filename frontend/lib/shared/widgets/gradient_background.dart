import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({required this.child,super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primaryContainer,
              0.4,
            )!,
            Theme.of(context).colorScheme.primaryContainer,
          ],
          stops: const [
            0.2,
            1,
          ],
        ),
      ),
      child: child,
  );
}