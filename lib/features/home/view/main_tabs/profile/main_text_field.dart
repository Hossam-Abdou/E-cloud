
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BuildTextField extends StatefulWidget {
  const BuildTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.label,
    this.hint,
    this.isObscured = false,
    this.iconData,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor,
    this.readOnly = false,
    this.validation,
    this.onTap,
    this.maxLines,
    this.prefixIcon, this.borderBackgroundColor, this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String? hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderBackgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;
  final void Function()? onTap;

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
                padding:  EdgeInsets.only(
                     top: 2.h),
                child: Text(
                  widget.label!,
                  style: widget.labelTextStyle ??
                      AppStyles.medium18TextStyle(color: AppColors.white)

                ),
              )
            : const SizedBox(),
        Container(
          margin:  EdgeInsets.only(top: 5.h),
          decoration: BoxDecoration(
            color: widget.backgroundColor ??
                Colors.grey.withOpacity(.15),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: widget.borderBackgroundColor ?? Colors.transparent )
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            style: AppStyles.medium18TextStyle(color: Colors.black),
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: widget.cursorColor ?? AppColors.black,
            onTap: widget.onTap,
            onEditingComplete: () {
              widget.focusNode?.unfocus();
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction: widget.nextFocus == null
                ? TextInputAction.done
                : TextInputAction.next,
            validator: (value) {
              if (widget.validation == null) {
                setState(() {
                  errorText = null;
                });
              } else {
                setState(() {
                  errorText = widget.validation!(value);
                });
              }
              return errorText;
            },
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.all(12.r),
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscured
                  ? IconButton(
                      onPressed: () {
                        setState(
                          () {
                            hidden = !hidden;
                          },
                        );
                      },
                      iconSize:24.sp,
                      isSelected: !hidden,
                      color: widget.cursorColor,
                      selectedIcon: const Icon(Icons.remove_red_eye_rounded),
                      icon: Icon(Icons.remove_red_eye_outlined),
                    )
                  : widget.suffixIcon,
              hintStyle: widget.hintTextStyle ??
                  AppStyles.medium18TextStyle(color: AppColors.grey),

              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              // errorStyle: TextStyle(
              //   fontSize: AppSize.s0,
              //   color: AppColors.transparent,
              // ),
            ),
          ),
        ),
        errorText == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left:8,
                ),
                child: Text(
                  errorText!,
                  style: AppStyles.medium18TextStyle(color: AppColors.white)

                ),
              ),
      ],
    );
  }
}
