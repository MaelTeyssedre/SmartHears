class User {
  User({this.avatarUrl, this.birthDate, this.city, this.country, this.firstname, this.lastname, required this.email, required this.id, this.phone});

  factory User.fromJson(dynamic json) => User(
      avatarUrl: json['avatarUrl'],
      birthDate: json['birthDate'],
      email: json['email'],
      id: json['id'],
      city: json['city'],
      country: json['country'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone']);

  Map<String, dynamic> toJson() => {
        'city': city,
        'country': country,
        'email': email,
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'avatarUrl': avatarUrl,
        'birthDate': birthDate,
        'phone': phone
      };

  final String? firstname;
  final String? lastname;
  final DateTime? birthDate;
  final String? city;
  final String? country;
  String? avatarUrl;
  final String? phone;
  final String id;
  final String email;
}
