import 'package:bandhu/theme/fonts.dart';
import 'package:bandhu/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AskGivePopup extends ConsumerStatefulWidget {
  const AskGivePopup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AskGivePopupState();
}

class _AskGivePopupState extends ConsumerState<AskGivePopup> {
  final TextEditingController _askController = TextEditingController();
  final TextEditingController _giveController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();

  onPressClose() => Navigator.pop(context);
  onPressCalendar() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
    }
    setState(() {});
  }

  onPressSend() {
    if (_askController.text.isEmpty ||
        _giveController.text.isEmpty ||
        _remarkController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill-in all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Add",
                  style: fontSemiBold16.copyWith(color: colorPrimary),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onPressClose,
                  icon: Icon(Icons.close, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: onPressCalendar,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        "${selectedDate.day}-${DateFormat('MMM').format(selectedDate)}-${selectedDate.year}",
                        style: fontMedium14.copyWith(color: black)),
                    const SizedBox(
                      width: 10,
                    ),
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _askController,
              decoration: const InputDecoration(
                labelText: 'Ask',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _giveController,
              decoration: const InputDecoration(
                labelText: 'Give',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _remarkController,
              decoration: const InputDecoration(
                labelText: 'Remark',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: colorPrimary,
              ),
              onPressed: onPressSend,
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
