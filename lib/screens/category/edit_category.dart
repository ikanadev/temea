import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
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
  CategoryColor _color = CategoryColor.red;
  final TextEditingController _textCont = TextEditingController();

  @override
  void initState() {
    _textCont.text = widget.category.name;
    _color = widget.category.color;
    super.initState();
  }

  void _setColor(CategoryColor color) {
    setState(() {
      _color = color;
    });
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  void _updateCategory() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    final catRepo = ref.read(categoryRepoProv);
    catRepo.updateCategory(widget.category.copyWith(
      name: _textCont.text,
      color: _color,
    ));
    _closeDialog();
  }

  String? _nameValidator(String? value) => categoryNameValidator(value, ref);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: const Text('New name'),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    autofocus: true,
                    controller: _textCont,
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
