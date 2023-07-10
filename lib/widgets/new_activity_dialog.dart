import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/utils/utils.dart';

import 'cancel_button.dart';
import 'icon_picker.dart';

class NewActivityDialog extends ConsumerStatefulWidget {
  const NewActivityDialog({super.key});

  @override
  NewActivityDialogState createState() => NewActivityDialogState();
}

class NewActivityDialogState extends ConsumerState<NewActivityDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCont = TextEditingController();
  String iconName = defaultIconName;

  void _setIconName(String name) => setState(() => iconName = name);

  void _closeDialog() => Navigator.of(context).pop();

  void _saveActivity() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    // TODO: handle save
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Activity'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text('Name'),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    autofocus: true,
                    maxLength: 24,
                    controller: _nameCont,
                    validator: nonEmptyValidator,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(child: Text('Icon')),
              IconButton.filledTonal(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => IconPicker(
                      iconName: iconName,
                      setIconName: _setIconName,
                    ),
                  );
                },
                icon: Icon(getIconData(iconName)),
                iconSize: 36,
              ),
            ],
          ),
        ],
      ),
      actions: [
        CancelButton(label: 'Cancel', onClick: _closeDialog),
        TextButton(onPressed: _saveActivity, child: const Text('Save'))
      ],
    );
  }
}
