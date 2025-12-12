import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/profile_model.dart';
import 'add_profile_screen.dart';

class ProfilesListScreen extends StatefulWidget {
  @override
  State<ProfilesListScreen> createState() => _ProfilesListScreenState();
}

class _ProfilesListScreenState extends State<ProfilesListScreen> {
  final db = DBHelper();
  List<ProfileModel> profiles = [];

  loadProfiles() async {
    profiles = await db.getProfiles();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profiles List")),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (_, i) {
          return Card(
            child: ListTile(
              title: Text(profiles[i].name ?? ""),
              subtitle: Text(profiles[i].contact ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    child: Text("View"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  AddProfileScreen(profile: profiles[i])));
                    },
                  ),
                  TextButton(
                    child: Text("Edit"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  AddProfileScreen(profile: profiles[i])));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
  //                 backgroundImage: imagePath != null
  //                     ? FileImage(File(imagePath!))
  //                     : AssetImage('assets/placeholder.png') as ImageProvider,
  //                 child: imagePath == null ? Icon(Icons.add_a_photo) : null,
  //               ),
  //             ),
  //             SizedBox(height: 16),
  //             TextFormField(
  //               controller: nameCtrl,
  //               decoration: InputDecoration(labelText: "Name"),
  //               validator: (value) =>
  //                   value!.isEmpty ? "Please enter a name" : null,
  //             ),
  //             TextFormField(
  //               controller: contactCtrl,
  //               decoration: InputDecoration(labelText: "Contact"),
  //               validator: (value) =>
  //                   value!.isEmpty ? "Please enter a contact" : null,
  //             ),
  //             TextFormField(
  //               controller: dobCtrl,
  //               decoration: InputDecoration(labelText: "Date of Birth"),
  //               validator: (value) =>
  //                   value!.isEmpty ? "Please enter date of birth" : null,
  //             ),
  //             TextFormField(
  //               controller: qualificationCtrl,
  //               decoration: InputDecoration(labelText: "Qualification"),
  //               validator: (value) =>
  //                   value!.isEmpty ? "Please enter qualification" : null,
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               child: Text(widget.profile == null ? "Add Profile" : "Update Profile"),
  //               onPressed: () async {
  //                 if (_formKey.currentState!.validate()) {
  //                   ProfileModel profile = ProfileModel(
  //                     id: widget.profile?.id,
  //                     name: nameCtrl.text,
  //                     contact: contactCtrl.text,
  //                     dob: dobCtrl.text,
  //                     qualification: qualificationCtrl.text,
  //                     imagePath: imagePath,
  //                   );

  //                   if (widget.profile == null) {
  //                     await db.insertProfile(profile);
  //                   } else {
  //                     await db.updateProfile(profile);
  //                   }

  //                   Navigator.pop(context);
  //                 }
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
