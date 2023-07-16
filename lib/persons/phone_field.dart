import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class PhoneField extends StatefulWidget {
  final String initial;

  final Function(bool, String) valid;

  const PhoneField({super.key, required this.valid, required this.initial});

  @override
  _PhoneFieldState createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  final _phoneController = MaskedTextController(mask: '+7 (000) 000-0000');
  final _phoneRegExp = RegExp(r'^\+7 \(\d{3}\) \d{3}-\d{4}$');
  bool _isValidPhone = true;

  @override
  void initState() {
    super.initState();
    _phoneController.text = this.widget.initial;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _validatePhone(String phone) {
    setState(() {
      _isValidPhone = _phoneRegExp.hasMatch(phone);
      this.widget.valid(_isValidPhone, phone.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Phone',
            hintText: '+7 (123) 456-7890',
            errorText: _isValidPhone ? null : 'Invalid phone number',
          ),
          onChanged: (value) {
            _validatePhone(value);
          },
        ),
      ],
    );
  }
}
