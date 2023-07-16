import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class EmailField extends StatefulWidget {
  final String initial;
  final Function(bool, String) valid;

  const EmailField({super.key, required this.valid, required this.initial});

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final _emailController = MaskedTextController(mask: '********************');
  final _emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  bool _isValidEmail = true;

  @override
  void initState() {
    super.initState();
    _emailController.text = this.widget.initial;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail(String email) {
    setState(() {
      _isValidEmail = _emailRegExp.hasMatch(email);
      this.widget.valid(_isValidEmail, email.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp('[ ]')), // Deny spaces
          ],
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: _isValidEmail ? null : 'Invalid email',
          ),
          onChanged: (value) {
            _validateEmail(value);
          },
        ),
      ],
    );
  }
}

