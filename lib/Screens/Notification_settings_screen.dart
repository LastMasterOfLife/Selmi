import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import '../Texts/Text.dart';

class NotificationSettingsScreen extends StatefulWidget {
  final String accesso;
  const NotificationSettingsScreen({Key? key, required this.accesso}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool isSwitchOn = true;
  final List<bool> checkValues = [true, false, true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: variant,
      appBar: AppBar(
        backgroundColor: primary,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        iconTheme: const IconThemeData(color: neutral),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("NOTIFICATIONS", style: TextStyle(color: neutral)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Push Notification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Expanded(child: Text(DescriptionNotification)),
                  Switch(
                    value: isSwitchOn,
                    onChanged: (newValue) => setState(() => isSwitchOn = newValue),
                    activeColor: primary,
                  ),
                ],
              ),
            ),
            // Checkbox list basata sull'accesso dell'utente
            if (widget.accesso == 'user' || widget.accesso == 'admin')
              ..._buildCheckboxList(0, 2), // "Your documentation", "Your machinary"
            const SizedBox(height: 20),
            if (widget.accesso == 'admin')
              ..._buildCheckboxList(2, 3), // "List item" aggiunta per admin

            const Padding(
              padding: EdgeInsets.only(left: 20, top: 16),
              child: Text("Email notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),

            // Ripetere la lista checkbox dopo Email notifications
            if (widget.accesso == 'user' || widget.accesso == 'admin')
              ..._buildCheckboxList(3, 5), // "Your documentation", "Your machinary"
            const SizedBox(height: 20),
            if (widget.accesso == 'admin')
              ..._buildCheckboxList(5, 6), // "List item" aggiunta per admin dopo email
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCheckboxList(int start, int end) {
    const List<String> checkboxTitles = [
      "Your documentation",
      "Your machinary",
      "List item",
      "Your documentation",
      "Your machinary",
      "List item",
    ];

    return List<Widget>.generate(end - start, (index) {
      return SettingCheckbox(
        title: checkboxTitles[start + index],
        value: checkValues[start + index],
        onChanged: isSwitchOn
            ? (newValue) => setState(() => checkValues[start + index] = newValue ?? false)
            : null,
      );
    });
  }
}

class SettingCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const SettingCheckbox({
    Key? key,
    required this.title,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: neutral, width: 2)),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          Checkbox(
            value: value,
            activeColor: primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
