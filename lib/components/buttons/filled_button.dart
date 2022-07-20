import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    Key? key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    required this.child,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  }) : super(key: key);
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final Widget? child;

  factory FilledButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) = _FilledButtonWithIcon;

  static ButtonStyle styleFrom({
    Color? primary,
    Color? onPrimary,
    Color? onSurface,
    Color? surfaceTintColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return ElevatedButton.styleFrom(
      primary: primary,
      onPrimary: onPrimary,
      onSurface: onSurface,
      shadowColor: null,
      shape: shape,
      side: side,
      splashFactory: splashFactory,
      surfaceTintColor: surfaceTintColor,
      animationDuration: animationDuration,
      alignment: alignment,
      enabledMouseCursor: enabledMouseCursor,
      enableFeedback: enableFeedback,
      elevation: 0,
      tapTargetSize: tapTargetSize,
      textStyle: textStyle,
      padding: padding,
      maximumSize: maximumSize,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style?.merge(
            ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          ) ??
          ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.primary,
            onPrimary: Theme.of(context).colorScheme.onPrimary,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

class _FilledButtonWithIcon extends FilledButton {
  _FilledButtonWithIcon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _FilledButtonWithIconChild(icon: icon, label: label),
        );
}

class _FilledButtonWithIconChild extends StatelessWidget {
  const _FilledButtonWithIconChild(
      {Key? key, required this.label, required this.icon})
      : super(key: key);

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}
