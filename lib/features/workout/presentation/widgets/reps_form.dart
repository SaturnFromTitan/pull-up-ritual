import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;

class RepsForm extends StatefulWidget {
  final void Function(int reps) onValidSubmit;
  final void Function()? onCancel;
  final int minValue;
  RepsForm({
    super.key,
    required this.onValidSubmit,
    this.onCancel,
    this.minValue = 0,
  });

  @override
  State<RepsForm> createState() => _RepsFormState();
}

class _RepsFormState extends State<RepsForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    var submitButton = ElevatedButton(
      onPressed: _isValid
          ? () {
              // run logic
              final reps = int.parse(_controller.text);
              widget.onValidSubmit(reps);

              // restore initial state
              _controller.clear();
              setState(() {
                _isValid = false;
              });
            }
          : null,
      child: Text('Submit'),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
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
              final currentIsValid = _formKey.currentState?.validate() ?? false;
              setState(() => _isValid = currentIsValid);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (int.parse(value) < widget.minValue) {
                return "Must be at least ${widget.minValue}";
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
