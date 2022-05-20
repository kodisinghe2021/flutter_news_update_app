import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.lable,
    required this.onTap,
    this.height = 50,
    this.width = 300,
    this.is_loading = false,
  }) : super(key: key);
  final String lable;
  final double width;
  final double height;
  final Function() onTap;
  final bool is_loading;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        child: is_loading
            ? const Center(child: CircularProgressIndicator(color: Colors.white,))
            : Text(
                lable,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
      ),
    );
  }
}
