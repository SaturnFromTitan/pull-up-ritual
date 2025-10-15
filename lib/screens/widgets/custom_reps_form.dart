import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;

class CustomRepsForm extends StatefulWidget {
  final void Function(int reps) onValidSubmit;
  final void Function()? onCancel;
  const CustomRepsForm({super.key, required this.onValidSubmit, this.onCancel});

  @override
  State<CustomRepsForm> createState() => _CustomRepsFormState();
}

class _CustomRepsFormState extends State<CustomRepsForm> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    var submitButton = ElevatedButton(
      onPressed: _isValid
          ? () {
              final reps = int.parse(controller.text);
              widget.onValidSubmit(reps);
              formKey.currentState!.reset();
            }
          : null,
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
            onChanged: (_) {
              final form = formKey.currentState;
              final currentIsValid = form?.validate() ?? false;
              setState(() => _isValid = currentIsValid);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          widget.onCancel == null
              ? submitButton
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: widget.onCancel,
                      child: Text('Cancel'),
                    ),
                    submitButton,
                  ],
                ),
        ],
      ),
    );
  }
}
