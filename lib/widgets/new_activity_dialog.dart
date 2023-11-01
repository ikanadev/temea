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
  final TextEditingController _nameContr = TextEditingController();
  String iconName = defaultIconName;
  Category? cat;
  String? _saveError;

  void _setIconName(String name) => setState(() => iconName = name);

  void _closeDialog() => Navigator.of(context).pop();

  void _clearSaveError() {
    if (_saveError != null) setState(() => _saveError = null);
  }

  void _saveActivity() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    final res = ref.read(activityRepoProv).saveActivity(
          name: _nameContr.text,
          iconName: iconName,
          category: cat,
        );
    res.match(
      () => _closeDialog(),
      (err) => setState(() => _saveError = err),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cats = ref.watch(categoriesProv);
    return AlertDialog(
      title: const Text('New Activity'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_saveError != null)
            Text(
              _saveError!,
              style: context.textTheme.bodySmall
                  ?.copyWith(color: context.colorScheme.error),
            ),
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: _nameContr,
              validator: nonEmptyValidator,
              onChanged: (_) => _clearSaveError,
              autofocus: true,
              focusNode: _nameFocusNode,
              maxLength: 24,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text('Icon', style: context.textTheme.labelLarge),
              ),
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
            items: cats.map((cat) {
              return DropdownMenuItem<Category>(
                value: cat,
                child: Row(
                  children: [
                    Icon(
                      Icons.square_rounded,
                      size: 20,
                      color: getCatColor(color: cat.color, context: context),
                    ),
                    const SizedBox(width: 4),
                    Text(cat.name, style: context.textTheme.labelLarge),
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
      actions: [
        CancelButton(label: 'Cancel', onClick: _closeDialog),
        TextButton(onPressed: _saveActivity, child: const Text('Save'))
      ],
    );
  }
}
