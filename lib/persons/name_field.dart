import 'package:flutter/material.dart';

class NameField extends StatefulWidget {
  final String title;
  final String initial;
  final Function(bool, String)? valid;

  const NameField(
      {super.key, required this.title, required this.initial, this.valid});

  @override
  _NameFieldState createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  TextEditingController _nameController = TextEditingController();
  bool _isValidName = true;

  @override
  void initState() {
    super.initState();
    _nameController.text = this.widget.initial;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _validateName(String value) {
    setState(() {
      _isValidName = value.trim().length < 20;
      if (this.widget.valid != null)
        this.widget.valid!(_isValidName, value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: this.widget.title,
            errorText: _isValidName ? null : 'Input correct value',
          ),
          onChanged: (value) {
            if (this.widget.valid != null) _validateName(value);
          },
        ),
      ],
    );
  }
}
