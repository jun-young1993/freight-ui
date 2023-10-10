class User {
  final String id;
  final String contact;
  final String email;
  final String name;

  const User({
    required this.id,
    required this.contact,
    required this.email,
    required this.name
  });

  factory User.guest(){
    return const User(
      id: "GUEST",
      contact: "GUEST",
      email: "GUEST",
      name: "GUEST"
    );
  }


}