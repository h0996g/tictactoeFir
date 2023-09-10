import 'package:flutter/material.dart';

class Button3d extends StatefulWidget {
  // const Button3d({super.key});
  final double? height;
  final double? width;
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final Widget text;
  final Function()? onTap;
  Button3d(
      {super.key,
      this.height,
      this.width,
      required this.text,
      this.color1,
      this.color2,
      this.color3,
      this.onTap});

  @override
  State<Button3d> createState() => _Button3dState();
}

class _Button3dState extends State<Button3d> {
  bool _iselevated = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _iselevated = false;
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _iselevated = true;
          });
        });
        widget.onTap!();
      },
      child: AnimatedContainer(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              color: widget.color1 ?? Colors.grey[300],
              borderRadius: BorderRadius.circular(50),
              boxShadow: _iselevated
                  ? [
                      BoxShadow(
                          color: widget.color2 ?? Colors.grey[500]!,
                          offset: const Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: widget.color3 ?? Colors.white,
                          offset: const Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1)
                    ]
                  : null),
          child: widget.text),
    );
  }
}
