import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


const int defaultFirstDate = 1950;
const int defaultLastDate = 2100;
const String defaultDateFormat = 'yyyy-MM-dd';



class DatePickerField extends TextFormField {

  DatePickerField({
    super.key,
    TextEditingController? controller,
    String? labelText = "",
    required BuildContext context,
    void Function(String selectedDate)? onSelected
  }) : super(
    decoration: InputDecoration(
      icon: const Icon(Icons.calendar_today),
      labelText: labelText
    ),
    readOnly: true,
    controller: controller,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(defaultFirstDate),
          lastDate: DateTime(defaultLastDate)
      );
      if(pickedDate != null){
        String dateFormat = DateFormat(defaultDateFormat).format(pickedDate);
        controller?.text = dateFormat;
        onSelected!(dateFormat);
      }
    }
  );

}