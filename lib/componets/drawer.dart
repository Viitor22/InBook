import 'package:flutter/material.dart';
import 'package:in_book/componets/my_list_tile.dart';
import 'package:in_book/theme/theme.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogoutTap;

  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: lightColorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          const DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
            ),
          ),
          // Menu items
          Expanded(
            child: Column(
              children: [
                MyListTile(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () => Navigator.pop(context),
                ),
                MyListTile(
                  icon: Icons.person,
                  text: 'Profile',
                  onTap: onProfileTap,
                ),
              ],
            ),
          ),
          // Logout
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'Logout',
              onTap: onLogoutTap,
            ),
          ),
        ],
      ),
    );
  }
}
