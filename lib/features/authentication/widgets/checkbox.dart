import 'package:flutter/material.dart';

class RoundedCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;

  const RoundedCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
  }) : super(key: key);

  @override
  _RoundedCheckboxState createState() => _RoundedCheckboxState();
}

class _RoundedCheckboxState extends State<RoundedCheckbox> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _toggleCheckbox() {
    setState(() {
      _value = !_value;
      widget.onChanged(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: _value ? widget.activeColor : Colors.transparent,
          border: Border.all(
            color: _value ? widget.activeColor : Colors.grey,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _value
            ? Icon(
                Icons.check,
                color: widget.checkColor,
                size: 16,
              )
            : null,
      ),
    );
  }
}
