import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultForm(
        {required TextEditingController controller,
        bool obscureText = false,
        bool readOnly = false,
        required TextInputAction textInputAction,
        Widget? suffixIcon,
        Widget? suffix,
        Icon? prefixIcon,
        String? label,
        String? hintText,
        int? maxLength,
        TextStyle? labelStyle,
        int maxLines = 1,
        TextInputType? type,
        required Function? validator,
        Function()? onTap,
        Function(dynamic)? onFieldSubmitted}) =>
    TextFormField(
      style: const TextStyle(color: Colors.white),
      onTap: onTap,
      readOnly: readOnly,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      textInputAction: textInputAction,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          // fillColor: Colors.white,
          labelStyle: labelStyle,
          hintText: hintText,
          suffixIcon: suffixIcon,
          suffix: suffix,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),
          labelText: label),
      controller: controller,
      validator: (String? value) {
        if (value!.isEmpty) {
          return validator!(value);
        }
        return null;
      },
    );

Widget defaultSubmit1(
        {formKey,
        Function()? onPressed,
        bool isothericon = false,
        Color background = Colors.blue,
        Widget? icon}) =>
    FloatingActionButton(
      backgroundColor: background,
      // onPressed: () {
      //   if (formKey.currentState!.validate()) {}
      // },
      onPressed: onPressed,
      child: !isothericon ? const Icon(Icons.arrow_forward_ios) : icon,
    );
Widget defaultSubmit2({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  Function()? onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, warning }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigatAndReturn({required context, required page}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));

void navigatAndFinish({required context, required page}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);

PreferredSizeWidget defaultAppBar(
        {
        // String? title,
        List<Widget>? actions,
        bool canreturn = true,
        Widget? title,
        Widget? leading,
        // Function()? whenBack,
        Function()? onPressed}) =>
    AppBar(
        titleSpacing: 0,
        leading: canreturn
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))
            : leading,
        title: title,
        actions: actions);

class Button3D extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;

  const Button3D({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.width = 300,
    this.height = 80,
  }) : super(key: key);

  @override
  _Button3DState createState() => _Button3DState();
}

class _Button3DState extends State<Button3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _shadowAnimation = Tween<double>(begin: 8.0, end: 3.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: _shadowAnimation.value,
                    offset: Offset(0, _shadowAnimation.value),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
