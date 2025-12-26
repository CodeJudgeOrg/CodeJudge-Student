import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Customised TextField
class MyEditText extends StatefulWidget {
  final bool multiline;
  final bool autocorrect;
  final bool suggestions;
  final bool autoSelect;
  final bool autofocus;
  final TextInputType textInputType;
  final String hint;
  final ValueChanged<String>? onInputDone;
  final String? text;

  const MyEditText({
    super.key,
    required this.hint,
    this.multiline = true,
    this.suggestions = false,
    this.autocorrect = false,
    this.autoSelect = false,
    this.autofocus = false,
    this.textInputType = TextInputType.text,
    this.onInputDone = null,
    this.text,
  });

  @override
  State<MyEditText> createState() => _MyEditTextState();
}

class _MyEditTextState extends State<MyEditText> {
  late TextEditingController _controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
    // Cursor at the end
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );

    focusNode = FocusNode();

    // Call backend tasks if focus lost
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        finalizeInput();
      }
    });
  }
  // Call backend tasks if closed
  @override
  void dispose() {
    finalizeInput();
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Perform backend tasks
  void finalizeInput() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onInputDone?.call(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int? maxLines = widget.multiline ? null : 1;

    return TextField(
      controller: _controller,
      focusNode: focusNode,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.suggestions,
      selectAllOnFocus: widget.autoSelect,
      autofocus: widget.autofocus,
      maxLines: maxLines,

      textInputAction:
          widget.multiline ? TextInputAction.newline : TextInputAction.done,

      onSubmitted: (_) => finalizeInput(),
      onTapOutside: (_) => finalizeInput(),
      onEditingComplete: () {
        finalizeInput();
      },

      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).hintColor,
        ),
      ),
    );
  }
}