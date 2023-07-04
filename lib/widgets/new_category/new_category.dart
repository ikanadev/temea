import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/category/category.dart';
import 'package:temea/utils/utils.dart';
import 'package:temea/widgets/widgets.dart';

import 'color_picker.dart';

class NewCategory extends ConsumerStatefulWidget {
  const NewCategory({super.key});

  @override
  NewCategoryState createState() => NewCategoryState();
}

class NewCategoryState extends ConsumerState<NewCategory> {
  final _formKey = GlobalKey<FormState>();
  CategoryColor _color = CategoryColor.red;
  final TextEditingController _textContr = TextEditingController();

  void _setColor(CategoryColor newColor) {
    setState(() {
      _color = newColor;
    });
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  void _saveCategory() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    ref
        .read(categoryProvider.notifier)
        .saveCategory(_textContr.text, _color)
        .whenComplete(_closeDialog);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create categories to classify your activities.',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: const Text('Name'),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    autofocus: true,
                    controller: _textContr,
                    maxLength: 24,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              const Expanded(child: Text('Color')),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        ColorPicker(color: _color, onSelect: _setColor),
                  );
                },
                child: Container(
                  width: 38,
                  height: 25,
                  decoration: BoxDecoration(
                    color: getCatColor(color: _color, context: context),
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        CancelButton(label: 'Cancel', onClick: _closeDialog),
        TextButton(onPressed: _saveCategory, child: const Text('Save')),
      ],
    );
  }
}
