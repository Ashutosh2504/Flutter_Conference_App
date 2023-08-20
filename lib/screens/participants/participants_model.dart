class ParticipantsModel {
  final String successCode;
  User user;
  // "successcode": "200",
  //   "user": {
  //       "id": "2",
  //       "name": "Ashutosh Demo",
  //       "email": "ashup953@gmail.com",
  //       "mobile": "123456789",
  //       "gender": "Male",
  //       "city": "Nagpur",
  //       "otp": "955084"
  ParticipantsModel({required this.successCode, required this.user});
}

class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String gender;
  final String city;
  final String otp;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.city,
    required this.otp,
  });
}
