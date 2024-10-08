import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailTextFormField extends StatefulWidget {
  const EmailTextFormField(
      {super.key, required this.controller, this.autovalidateMode});
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  @override
  State<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  bool shown = false;
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: widget.autovalidateMode,
      onFieldSubmitted: (value) async {
        isValid = value.isNotEmpty && EmailValidator.validate(value);
        shown = true;
        setState(() {});
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          isValid = value != null &&
              value.isNotEmpty &&
              EmailValidator.validate(value);
          shown = true;
          setState(() {});
          return 'Email is required';
        }
        if (!EmailValidator.validate(value)) {
          isValid = value.isNotEmpty && EmailValidator.validate(value);
          shown = true;
          setState(() {});
          return 'Invalid email';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      cursorColor: Colors.green[900],
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        floatingLabelStyle: TextStyle(
          color: Colors.green[900],
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.sp,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.sp,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.green[900]!,
            width: 2.sp,
          ),
        ),
        hintStyle: const TextStyle(color: Colors.black45),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.green[900]!,
            width: 1.sp,
          ),
        ),
        suffixIcon: shown
            ? Icon(
                isValid ? Icons.check : Icons.close,
                color: isValid ? Colors.green : Colors.red,
              )
            : null,
      ),
    );
  }
}
