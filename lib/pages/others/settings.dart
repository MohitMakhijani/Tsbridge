import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the home page
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Notification Settings'),
              subtitle: Text('Configure notification preferences'),
              onTap: () {
                // Navigate to the notification settings page
                Navigator.pushNamed(context, '/notificationsettings');
              },
            ),
            Divider(),
            ListTile(
              title: Text('Account Settings'),
              subtitle: Text('Manage your account details'),
              onTap: () {
                // Navigate to the account settings page
                Navigator.pushNamed(context, '/accountsettings');
              },
            ),
            Divider(),
            ListTile(
              title: Text('Privacy Settings'),
              subtitle: Text('Adjust privacy preferences'),
              onTap: () {
                // Navigate to the privacy settings page
                Navigator.pushNamed(context, '/privacysettings');
              },
            ),
            Divider(),
            // Add more settings as needed
          ],
        ),
      ),
      // Add leading icon to the AppBar for the back button

    );
  }
}
