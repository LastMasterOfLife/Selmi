import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Accessibility_settings_screen.dart';
import 'package:prove/Screens/Account_manager_main_screen.dart';
import 'package:prove/Screens/Display_settings_screen.dart';
import 'package:prove/Screens/Language_settings_screen.dart';
import 'package:prove/Screens/Login_screen.dart';
import 'package:prove/Screens/Security_settings_screen.dart';
import 'package:prove/main.dart';
import 'Notification_settings_screen.dart';

class SettingsMainScreen extends StatefulWidget {
  final String accesso;
  final String? name;
  final String? surname;
  final String? username;
  final String? emaiil;
  final String? password;
  final String? serialcode;

  const SettingsMainScreen({super.key, required this.accesso,  this.name, this.surname, this.username, this.emaiil, this.password, this.serialcode});

  @override
  State<SettingsMainScreen> createState() => _SettingsMainScreenState();
}

class _SettingsMainScreenState extends State<SettingsMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: variant,
      appBar: AppBar(
        title: const Text(
          "SETTINGS",
          style: TextStyle(color: neutral, fontSize: 30),
        ),
        backgroundColor: primary,
      ),
      body: Column(
        children: [
          _buildSectionTitle(context, "ACCOUNT"),
          _buildSettingItem(
            context,
            "Account Management",
            "assets/images/user_icon_settings.png",
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountManagerMainScreen(
                  name: widget.name,
                  surname: widget.surname,
                  username: widget.username,
                  emaiil: widget.emaiil,
                  password: widget.password,
                  serialcode: widget.serialcode,
                ),
              ),
            ),
          ),
          _buildSettingItem(
            context,
            "Notifications",
            "assets/images/notification_icon.png",
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationSettingsScreen(
                  accesso: widget.accesso,
                ),
              ),
            ),
          ),
          _buildSettingItem(
            context,
            "Sign Out",
            "assets/images/log_out_icon.png",
                () => _showSignOutDialog(context),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle(context, "GENERAL"),
          _buildSettingItem(
            context,
            "Display",
            "assets/images/display_icon.png",
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplaySettingsScreen(
                  accesso: widget.accesso,
                ),
              ),
            ),
          ),
          _buildSettingItem(
            context,
            "App Language",
            "assets/images/language_icon.png",
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LanguageSettingsScreen()),
            ),
          ),
          _buildSettingItem(
            context,
            "Security",
            "assets/images/lock_icon.png",
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecuritySettingsScreen()),
            ),
          ),
          _buildSettingItem(
            context,
            "Accessibility",
            "assets/images/accessibility_icon.png",
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccessibilitySettingsScreen()),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // Dialog di conferma per il sign out
  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sign Out", style: TextStyle(color: primary)),
          content: const Text(
            "Sei sicuro di voler uscire? Dovrai accedere nuovamente.",
            style: TextStyle(color: primary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il popup
              },
              child: const Text("Annulla", style: TextStyle(color: primary)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il popup
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(
                      name: '',
                      surname: '',
                      username: '',
                      emaiil: '',
                      password: '',
                      serialcode: '',
                    ),
                  ),
                      (Route<dynamic> route) => false, // Rimuovi tutte le schermate precedenti
                );
                print("Uscito");
              },
              child: const Text("Esci", style: TextStyle(color: error)),
            ),
          ],
        );
      },
    );
  }

  // Costruisce il titolo di ogni sezione
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 10, bottom: 2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  // Costruisce un singolo elemento delle impostazioni con icona e navigazione
  Widget _buildSettingItem(BuildContext context, String title, String iconPath, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: neutral, width: 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Image.asset(iconPath),
                const SizedBox(width: 15),
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                const Spacer(),
                Image.asset('assets/images/right_icon.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
