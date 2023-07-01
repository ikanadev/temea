import 'package:flutter/material.dart';
import 'package:temea/utils/utils.dart';
import 'package:temea/widgets/color_picker.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  final _formKey = GlobalKey<FormState>();
  CategoryColor _color = CategoryColor.red;

  void _setColor(CategoryColor newColor) {
    setState(() {
      _color = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create new category',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
            ),
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
                  child: TextFormField(
                    autofocus: true,
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
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // register category
            }
          },
          child: const Text('Save'),
        )
      ],
    );
  }
}
