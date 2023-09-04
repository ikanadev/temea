import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/extension/context.dart';
import 'package:temea/providers/providers.dart';
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
  final _nameFocusNode = FocusNode();
  String name = '';
  String? _nameError;
  String iconName = defaultIconName;
  Category? cat;

  void _setIconName(String name) => setState(() => iconName = name);

  void _closeDialog() => Navigator.of(context).pop();

  void _saveActivity() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    try {
      ref.read(activityRepoProv).saveActivity(
            name: name,
            iconName: iconName,
            category: cat,
          );
      Navigator.of(context).pop();
    } catch (e) {
      if (e is AppException && e.err == AppError.alreadyExists) {
        setState(() => _nameError = e.msg);
        _formKey.currentState?.validate();
      } else {
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cats = ref.watch(categoriesProv);
    return AlertDialog(
      title: const Text('New Activity'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please provide a name';
                }
                return _nameError;
              },
              onChanged: (value) {
                if (_nameError != null) setState(() => _nameError = null);
                name = value;
              },
              autofocus: true,
              focusNode: _nameFocusNode,
              maxLength: 24,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Icon',
                  style: context.textTheme.labelLarge,
                )),
                IconButton.filledTonal(
                  onPressed: () {
                    _nameFocusNode.unfocus();
                    showDialog(
                      context: context,
                      builder: (_) => IconPicker(
                        iconName: iconName,
                        setIconName: _setIconName,
                      ),
                    );
                  },
                  icon: Icon(
                    getIconData(iconName),
                    color: cat == null
                        ? null
                        : getCatColor(color: cat!.color, context: context),
                  ),
                  iconSize: 30,
                ),
              ],
            ),
            DropdownButtonFormField<Category>(
              decoration: const InputDecoration(labelText: 'Category'),
              items: cats.map((c) {
                return DropdownMenuItem<Category>(
                  value: c,
                  child: Row(
                    children: [
                      Icon(
                        Icons.square_rounded,
                        size: 20,
                        color: getCatColor(color: c.color, context: context),
                      ),
                      const SizedBox(width: 4),
                      Text(c.name, style: context.textTheme.labelLarge),
                    ],
                  ),
                );
              }).toList(),
              value: cat,
              hint: const Text('Pick a category'),
              onChanged: (value) => setState(() => cat = value),
            ),
          ],
        ),
      ),
      actions: [
        CancelButton(label: 'Cancel', onClick: _closeDialog),
        TextButton(onPressed: _saveActivity, child: const Text('Save'))
      ],
    );
  }
}
