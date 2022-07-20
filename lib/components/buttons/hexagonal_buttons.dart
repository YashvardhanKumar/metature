import 'package:flutter/material.dart';
import 'package:metature/components/buttons/filled_button.dart';
import 'package:metature/components/buttons/filled_tonal_button.dart';
import 'package:metature/components/clipper/hexagonal_clipper.dart';

class FilledTonalHexagonalButton extends StatelessWidget {
  const FilledTonalHexagonalButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipPath(
        clipper: HexagonalShape(),
        child: FilledTonalButton(
          onPressed: onPressed,
          style: FilledTonalButton.styleFrom(
              shape: const RoundedRectangleBorder()),
          child: child,
        ),
      ),
    );
  }
}

class FilledHexagonalButton extends StatelessWidget {
  const FilledHexagonalButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipPath(
        clipper: HexagonalShape(),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(shape: const RoundedRectangleBorder()),
          child: child,
        ),
      ),
    );
  }
}