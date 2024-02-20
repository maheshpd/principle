class SchoolModel {
  final String id;
  final String name;
  final String email;
  final String password;

  SchoolModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  SchoolModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
  }) {
    return SchoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory SchoolModel.fromMap(Map<String, dynamic> map) {
    return SchoolModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  String toString() {
    return 'SchoolModel(id: $id, name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant SchoolModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}
