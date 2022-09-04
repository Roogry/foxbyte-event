import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_text.dart';

class KTextFormField extends StatelessWidget {
  KTextFormField({
    Key? key,
    required this.hintText,
    this.labelText,
    required this.textInputType,
    required this.textInputAction,
    required this.textEditingController,
    this.textAlignVertical,
    this.focusNode,
    this.errorText,
    this.validator,
    this.focus,
    this.inputFormatter,
    this.prefix,
    this.isPrefixAsset = false,
    this.prefixAsset,
    this.limit,
    this.maxText,
    this.isEnable = true,
    this.enableObscure = false,
    this.suffix,
    this.color,
    this.hasLabel = true,
    this.border,
    this.bgColor,
    this.contentPadding,
    this.onChange,
  }) : super(key: key);

  int? color;
  final String? hintText, labelText, errorText;
  Function? validator, focus;
  bool isEnable;
  FocusNode? focusNode;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  List<TextInputFormatter>? inputFormatter;
  int? limit;
  int? maxText;
  final TextInputAction textInputAction;
  TextAlignVertical? textAlignVertical;
  bool enableObscure;
  String? prefix;
  String? prefixAsset;
  bool? isPrefixAsset;
  Widget? suffix;
  bool hasLabel;
  BoxBorder? border;
  Color? bgColor;
  EdgeInsetsGeometry? contentPadding;
  Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (val) {
        if (validator != null) {
          var result = validator!(textEditingController.text);
          return result;
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 0),
              decoration: BoxDecoration(
                  border: border ??
                      Border.all(color: Colors.grey.shade300, width: 1.5),
                  borderRadius: Helper.getRadius(10, isAll: true),
                  color: !isEnable ? ColorConfig.grey : bgColor ?? ColorConfig.white),
              child: TextFormField(
                textInputAction: textInputAction,
                inputFormatters: inputFormatter,
                onFieldSubmitted: focus as void Function(String)?,
                keyboardType: textInputType,
                maxLines: limit ?? 1,
                enabled: isEnable,
                maxLength: maxText,
                obscureText: enableObscure,
                controller: textEditingController,
                onChanged: onChange,
                textAlignVertical: textAlignVertical,
                style: const TextStyle(
                  color: ColorConfig.blackText,
                  fontSize: 16,
                  fontFamily: "SFPro",
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  filled: true,
                  label: hasLabel
                      ? KText(
                          text: labelText ?? hintText,
                          color: ColorConfig.hintText,
                        )
                      : null,
                  counter: Container(),
                  isDense: true,
                  hintStyle: const TextStyle(color: ColorConfig.hintText),
                  fillColor: Colors.transparent,
                  contentPadding: contentPadding ??
                      const EdgeInsets.symmetric(horizontal: 16),
                  errorMaxLines: 2,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 16),
                    child: suffix,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                  ),
                  prefixIcon: isPrefixAsset == true && prefixAsset != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16, right: 10),
                          child: Image.asset(
                            prefixAsset!,
                            color: textEditingController.text.isNotEmpty
                                ? ColorConfig.primaryColor
                                : ColorConfig.greyImage,
                          ),
                        )
                      : prefix != null
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                              child: KText(text: prefix),
                            )
                          : null,
                  floatingLabelBehavior:
                      hasLabel ? FloatingLabelBehavior.auto : null,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
            Offstage(
              offstage: !state.hasError,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorConfig.red,
                  borderRadius: Helper.getRadius(4, isAll: true),
                ),
                margin: const EdgeInsets.only(top: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: KText(
                  text: state.errorText,
                  color: ColorConfig.white,
                  fontSize: 12,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
