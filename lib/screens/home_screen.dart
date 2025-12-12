import 'package:flutter/material.dart';
import 'add_profile_screen.dart';
import 'profiles_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Manager")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: Text("Add Profile"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddProfileScreen()));
                }),
            SizedBox(height: 20),
            ElevatedButton(
                child: Text("Profiles List"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProfilesListScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
