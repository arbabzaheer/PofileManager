class ProfileModel {
  int? id;
  String? name;
  String? contact;
  String? dob;
  String? qualification;
  String? imagePath;

  ProfileModel(
      {this.id,
      this.name,
      this.contact,
      this.dob,
      this.qualification,
      this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'dob': dob,
      'qualification': qualification,
      'imagePath': imagePath,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        id: json['id'],
        name: json['name'],
        contact: json['contact'],
        dob: json['dob'],
        qualification: json['qualification'],
        imagePath: json['imagePath'],
      );
}
