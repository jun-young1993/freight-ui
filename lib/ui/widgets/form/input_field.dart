import 'package:flutter/material.dart';

enum InputFieldType {
  text
}

class InputField extends StatelessWidget {
  final InputFieldType type;

  const InputField({
    super.key, 
    this.type = InputFieldType.text
  });

  @override
  Widget build(BuildContext context) {
    return _buildSelector();
  }

  Widget _buildSelector() {
    return Container(

    );
  }

}