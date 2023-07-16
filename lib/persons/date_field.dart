import 'package:flutter/material.dart';

class DateField extends StatefulWidget {
  final int initial;
  final Function(bool, int) valid;

  const DateField({super.key, required this.valid, required this.initial});

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime? _selectedDate;
  bool _isValidDate = true;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.fromMillisecondsSinceEpoch(this.widget.initial);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        if (_selectedDate!
            .isAfter(DateTime.now().add(Duration(days: -1 * 365 * 18))))
          _isValidDate = false;
        else
          _isValidDate = true;
        this.widget.valid(_isValidDate, _selectedDate!.millisecondsSinceEpoch);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Date'),
          subtitle: Text(
            _selectedDate == null
                ? 'Select a date'
                : (_selectedDate!.day.toString() +
                    '-' +
                    _selectedDate!.month.toString() +
                    '-' +
                    _selectedDate!.year.toString()),
            style: TextStyle(color: _isValidDate ? null : Colors.red),
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () {
            _selectDate(context);
          },
        ),
        if (!_isValidDate)
          Text(
            'You are too young',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
