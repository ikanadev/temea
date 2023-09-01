import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/widgets/widgets.dart';

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
    final catRepo = ref.read(categoryRepoProv);
    catRepo.saveCategory(color: _color, name: _textContr.text);
    ref.invalidate(categoriesProv);
    _closeDialog();
  }

  String? _nameValidator(String? value) {
    if (value == null) return 'Please enter a value';
    final cleanValue = value.trim().toLowerCase();
    if (cleanValue.isEmpty) return 'Please enter a value';
    final cats = ref.read(categoriesProv);
    if (cats.indexWhere((c) => c.name.toLowerCase() == cleanValue) >= 0) {
      return '${value.trim()} already exists';
    }
    return null;
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
          const SizedBox(height: 24),
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
                  child: TextFormField(
                    autofocus: true,
                    controller: _textContr,
                    maxLength: 24,
                    validator: _nameValidator,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(child: Text('Color')),
              ColorPickerButton(color: _color, onSelect: _setColor),
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
