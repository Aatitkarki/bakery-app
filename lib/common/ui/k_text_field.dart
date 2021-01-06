import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class KOutlineTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyBoardType;
  final FocusNode focusNode;
  final IconData prefixIcon, suffixIcon;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final Function(String) validate;
  final bool password;
  final bool enabled;
  final Function onSuffixTap;
  final Color color;
  final TextStyle textStyle;
  final TextAlign textAlign;

  final int maxLines, minLines;

  const KOutlineTextField({
    Key key,
    this.maxLines,
    this.minLines,
    this.controller,
    this.hintText,
    this.focusNode,
    this.color,
    this.prefixIcon,
    this.onSubmitted,
    this.onChanged,
    this.validate,
    this.enabled = true,
    this.password = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.keyBoardType = TextInputType.text,
  }) : super(key: key);

  @override
  _KOutlineTextFieldState createState() => _KOutlineTextFieldState();
}

class _KOutlineTextFieldState extends State<KOutlineTextField> {
  bool _password;
  bool _togglePassword = false;
  TextEditingController controller;

  @override
  void initState() {
    _password = widget.password;
    if (_password) {
      _togglePassword = true;
    }

    // if (widget.controller == null)
    //   controller = TextEditingController();
    // else
    //   controller = widget.controller;
    // controller.text = widget.initialValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _password,
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      validator: widget.validate,
      autovalidate: true,
      minLines: widget.minLines ?? 1,
      maxLines: widget.maxLines ?? 1,
      style: widget.textStyle,
      textAlign: widget.textAlign,
      keyboardType: widget.keyBoardType,
      decoration: InputDecoration(
        prefixIcon:
            (widget.prefixIcon != null) ? Icon(widget.prefixIcon) : null,
        hintText: widget.hintText,
        suffixIcon: (widget.password || widget.suffixIcon != null)
            ? GestureDetector(
                onTap: () {
                  if (widget.onSuffixTap != null) {
                    widget.onSuffixTap();
                  }
                  if (_togglePassword)
                    setState(() {
                      _password = !_password;
                    });
                },
                child: Icon((widget.suffixIcon != null)
                    ? widget.suffixIcon
                    : _password ? Feather.eye : Feather.eye_off),
              )
            : null,
        // prefix: Icon(AntDesign.lock1),
      ),
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}

class KTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final IconData prefixIcon, suffixIcon;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final Function(String) validate;
  final bool password;
  final bool enabled;
  final Function onSuffixTap;
  final Color color;

  const KTextField({
    Key key,
    this.controller,
    this.hintText,
    this.focusNode,
    this.color,
    this.prefixIcon,
    this.onSubmitted,
    this.onChanged,
    this.validate,
    this.enabled = true,
    this.password = false,
    this.suffixIcon,
    this.onSuffixTap,
  }) : super(key: key);

  @override
  _KTextFieldState createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool _password;
  String _error;

  @override
  void initState() {
    _password = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          color: widget.color ?? Theme.of(context).cardColor,
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              (widget.prefixIcon != null)
                  ? Container(
                      width: 44,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .primaryColor
                            .withOpacity(widget.enabled ? 1 : 0.65),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.prefixIcon,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: TextFormField(
                  obscureText: _password,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  enabled: widget.enabled,
                  onChanged: (text) {
                    if (widget.onChanged != null) widget.onChanged(text);
                    if (widget.validate != null) {
                      setState(() {
                        _error = widget.validate(text);
                      });
                    }
                  },
                  validator: widget.validate,
                  autovalidate: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorStyle: TextStyle(fontSize: 0, height: 0),
                    hintText: widget.hintText,
                    suffixIcon: widget.password
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _password = !_password;
                              });
                            },
                            child:
                                Icon(_password ? Feather.eye : Feather.eye_off),
                          )
                        : null,
                    // prefix: Icon(AntDesign.lock1),
                  ),
                  onFieldSubmitted: widget.onSubmitted,
                ),
              ),
              (widget.suffixIcon != null)
                  ? InkWell(
                      onTap: widget.onSuffixTap,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(widget.enabled ? 1 : 0.65),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            widget.suffixIcon,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        (_error != null)
            ? Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Text(_error, style: TextStyle(color: Colors.red)),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
