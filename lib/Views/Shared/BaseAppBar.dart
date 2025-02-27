import 'package:flutter/material.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Views/EditUserView.dart';
import 'package:vetdrugegy/Views/LoginView.dart';
import 'package:vetdrugegy/Views/NotificationsView.dart';
import '../../Models/Constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final BuildContext widgetContext;
  final bool? showBackButton;
  final bool? showSearch;
  final bool? showNotification;
  final int? unreadNotificationsCount;
  final void Function()? onNotificationPressed;

  BaseAppBar({
    required this.appBar,
    required this.widgetContext,
    required this.showBackButton,
    this.showSearch,
    this.showNotification,
    this.unreadNotificationsCount,
    this.onNotificationPressed,
  }) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: appDesign.colorPrimary,
      leading: InkWell(
        onTap: () {},
        child: Visibility(
          child: BackButton(
              color: appDesign.colorAccent,
              onPressed: () {
                Navigator.pop(context);
              }),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: showBackButton!,
        ),
      ),
      title: Image.asset('images/applogo.png', height: 50, fit: BoxFit.fill),
      actions: <Widget>[
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: showSearch ?? false,
          child: IconButton(
              icon: Icon(
                Icons.search,
                color: appDesign.colorAccent,
                size: 25,
              ),
              onPressed: () {
                //
              }),
        ),
        Visibility(
          visible: showNotification ?? false,
          child: Stack(
            alignment:
                Alignment.topRight, // Positions the badge at the top-right
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: appDesign.colorAccent,
                ),
                onPressed: onNotificationPressed,
              ),
              if (unreadNotificationsCount != null)
                if (unreadNotificationsCount! >
                    0) // Only show the badge if there are unread notifications
                  Positioned(
                    right: 8, // Adjust the position as needed
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red, // Badge background color
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$unreadNotificationsCount',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 12, // Adjust font size as needed
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
        Visibility(
            // showNotification == null ? true: showNotification!
            visible: true,
            child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: appDesign.colorAccent,
                ),
                onPressed: () {
                  if (UserData.userId == 0) {
                    context.navigateTo(LoginView());
                  } else {
                    context.navigateTo(EditUserView());
                  }
                })),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
