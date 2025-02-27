import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/Constants.dart';
import 'package:vetdrugegy/main.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  List<Map<String, String?>> notifications = [];
  @override
  initState() {
    print('initState');
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    notifications = await getStoredNotifications();
    setReadNotificationsCount(notifications.length);
    setState(() {});
    print(notifications.length);
  }

  Future<void> clearNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
  }

  // set read notifications count
  Future<void> setReadNotificationsCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('readNotificationsCount', count);
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appDesign.colorPrimaryDark,
        foregroundColor: appDesign.colorAccent,
        title: Text(
          AppLocalizations.of(context)!.notifications,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await clearNotifications();
              _initializeNotifications();
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: appDesign.colorPrimaryLight,
                    width: 1,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(notifications[index]['title'] ?? ''),
                subtitle: Text(notifications[index]['body'] ?? ''),
                leading: Icon(Icons.notifications),
              ),
            );
          }),
    );
  }
}
