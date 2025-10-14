import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;

class CustomRepsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final void Function() onValidSubmit;
  final bool hasCancel;
  final void Function() onCancel;
  const CustomRepsForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.onValidSubmit,
    this.hasCancel = false,
    this.onCancel = _noop,
  });

  static void _noop() {}

  @override
  Widget build(BuildContext context) {
    var submitButton = ElevatedButton(
      onPressed: () {
        final form = formKey.currentState!;
        if (form.validate()) {
          onValidSubmit();
        }
      },
      child: Text('Submit'),
    );

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            maxLength: 2,
            decoration: InputDecoration(
              hintText: "Tap to enter reps",
              counterText: "",
            ),
            textAlign: TextAlign.center,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
            ],
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          hasCancel
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: onCancel, child: Text('Cancel')),
                    submitButton,
                  ],
                )
              : submitButton,
        ],
      ),
    );
  }
}
