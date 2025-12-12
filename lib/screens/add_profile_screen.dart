import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_helper.dart';
import '../models/profile_model.dart';

class AddProfileScreen extends StatefulWidget {
  final ProfileModel? profile;
  AddProfileScreen({this.profile});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final db = DBHelper();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController contactCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController qualificationCtrl = TextEditingController();

  String? imagePath;

  @override
  void initState() {
    super.initState();

    if (widget.profile != null) {
      nameCtrl.text = widget.profile!.name!;
      contactCtrl.text = widget.profile!.contact!;
      dobCtrl.text = widget.profile!.dob!;
      qualificationCtrl.text = widget.profile!.qualification!;
      imagePath = widget.profile!.imagePath;
    }
  }

  pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => imagePath = img.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.profile == null ? "Add Profile" : "Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imagePath != null
                      ? FileImage(File(imagePath!))
                      : AssetImage("assets/default_user.png") as ImageProvider,
                ),
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                controller: contactCtrl,
                decoration: InputDecoration(labelText: "Contact"),
              ),
              TextFormField(
                controller: dobCtrl,
                readOnly: true,
                decoration: InputDecoration(labelText: "Date of Birth"),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                  );
                  if (picked != null) {
                    dobCtrl.text = picked.toString().split(" ")[0];
                  }
                },
              ),
              TextFormField(
                controller: qualificationCtrl,
                decoration: InputDecoration(labelText: "Qualification"),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                  child: Text(widget.profile == null ? "Save" : "Update"),
                  onPressed: () async {
                    ProfileModel p = ProfileModel(
                      id: widget.profile?.id,
                      name: nameCtrl.text,
                      contact: contactCtrl.text,
                      dob: dobCtrl.text,
                      qualification: qualificationCtrl.text,
                      imagePath: imagePath,
                    );

                    widget.profile == null
                        ? await db.insertProfile(p)
                        : await db.updateProfile(p);

                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
