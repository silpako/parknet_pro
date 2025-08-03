import 'package:flutter/material.dart';

void showDeleteDialog(
  BuildContext context,
  String text,
  Future<void> Function() deleteFunction,
) {
  bool isDeleting = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              "Confirm Delete",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text("Are you sure you want to delete this $text?"),
            actions: [
              if (!isDeleting)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
              TextButton(
                onPressed:
                    isDeleting
                        ? null
                        : () async {
                          setState(() => isDeleting = true);
                          await deleteFunction();
                          if (context.mounted) Navigator.of(context).pop();
                        },
                child:
                    isDeleting
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
              ),
            ],
          );
        },
      );
    },
  );
}
