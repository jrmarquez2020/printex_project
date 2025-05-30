import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:printex/about_the_app_screen.dart';
import 'package:printex/faq_screen.dart';
import 'package:printex/how_use_the_app_screen.dart';
import 'package:printex/privacy_policy_screen.dart';
import 'profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  void _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Confirm Logout"),
            content: Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Logout", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (shouldLogout == true) {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), automaticallyImplyLeading: false),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Profile"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProfileScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text("How to use the app"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HowToUseAppScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text("FAQ"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FaqScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text("About the App"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AboutAppScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text("Privacy Policy"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700], // gray button
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () => _confirmLogout(context),
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text("Logout", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
