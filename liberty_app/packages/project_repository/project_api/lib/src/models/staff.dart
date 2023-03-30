/// Staff to be Assigned
class Staff {
  /// staff constructor
  const Staff({this.image, this.name});

  /// convert json map to Staff Object
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      image: json['image'] as String,
      name: json['name'] as String,
    );
  }

  /// staff image
  final String? image;

  /// staff name
  final String? name;

}
