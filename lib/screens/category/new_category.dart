import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/utils/utils.dart';
import 'package:temea/widgets/widgets.dart';

class NewCategory extends ConsumerStatefulWidget {
  const NewCategory({super.key});

  @override
  NewCategoryState createState() => NewCategoryState();
}

class NewCategoryState extends ConsumerState<NewCategory> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textContr = TextEditingController();
  CategoryColor _color = CategoryColor.red;
  String? _saveError;

  void _clearSaveError() {
    if (_saveError != null) {
      setState(() => _saveError = null);
    }
  }

  void _setColor(CategoryColor newColor) {
    _clearSaveError();
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
    final res = catRepo.saveCategory(color: _color, name: _textContr.text);
    res.match(
      () => _closeDialog(),
      (err) => setState(() => _saveError = err),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('New category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create categories to classify your activities.',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          if (_saveError != null)
            Text(
              _saveError!,
              style:
                  textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
            ),
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
                    validator: categoryNameValidator,
                    onChanged: (_) => _clearSaveError(),
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
