import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/core/utils/utils.dart';

class PasteIconButton extends IconButton {

  PasteIconButton({
    super.key,
    required TextEditingController controller
  }) : super(
    enableFeedback: true,
    onPressed: () {
      FocusManager.instance.primaryFocus?.unfocus();
      Utils.pasteToField(controller);
    },
    icon: const Icon(CupertinoIcons.doc_text),
  );

}
