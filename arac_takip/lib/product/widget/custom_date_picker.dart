import 'package:arac_takip/feature/home/view/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime selectedDateTime;
  const CustomDatePicker(this.selectedDateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(focusColor: Colors.red, backgroundColor: Colors.blue.shade700),
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2022, 1, 1),
          maxTime: DateTime(2100, 1, 1),
          onChanged: (selectedDateTime) {
            print('change $selectedDateTime');
          },
          onConfirm: (selectedDateTime) {
            print('confirm $selectedDateTime');
          },
          currentTime: DateTime.now(),
          locale: LocaleType.tr,
        );
      },
      icon: const Icon(Icons.calendar_month),
      color: Colors.blue,
    );
  }
}
