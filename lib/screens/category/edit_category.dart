import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/extension/context.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/utils/utils.dart';
import 'package:temea/widgets/widgets.dart';

class EditCategory extends ConsumerStatefulWidget {
  const EditCategory({super.key, required this.category});
  final Category category;

  @override
  EditCategoryState createState() {
    return EditCategoryState();
  }
}

class EditCategoryState extends ConsumerState<EditCategory> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textCont = TextEditingController();
  CategoryColor _color = CategoryColor.red;
  String? _updateErr;

  @override
  void initState() {
    _textCont.text = widget.category.name;
    _color = widget.category.color;
    super.initState();
  }

  void _setColor(CategoryColor color) => setState(() => _color = color);

  void _closeDialog() => Navigator.of(context).pop();

  void _updateCategory() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    final catRepo = ref.read(categoryRepoProv);
    final res = catRepo.updateCategory(widget.category.copyWith(
      name: _textCont.text,
      color: _color,
    ));
    res.match(() => _closeDialog(), (err) => setState(() => _updateErr = err));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_updateErr != null)
            Text(
              _updateErr!,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: const Text('New name'),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    autofocus: true,
                    controller: _textCont,
                    maxLength: 24,
                    validator: categoryNameValidator,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(child: Text('New color')),
              ColorPickerButton(color: _color, onSelect: _setColor),
            ],
          ),
        ],
      ),
      actions: [
        CancelButton(label: 'Cancel', onClick: _closeDialog),
        TextButton(onPressed: _updateCategory, child: const Text('Save')),
      ],
    );
  }
}
