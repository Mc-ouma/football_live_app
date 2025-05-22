import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool isAnonymous;
  final bool emailVerified;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;
  
  const User({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.isAnonymous = false,
    this.emailVerified = false,
    this.creationTime,
    this.lastSignInTime,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoUrl,
    isAnonymous,
    emailVerified,
    creationTime,
    lastSignInTime,
  ];
  
  bool get isAuthenticated => !isAnonymous && uid.isNotEmpty;
  
  User copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isAnonymous,
    bool? emailVerified,
    DateTime? creationTime,
    DateTime? lastSignInTime,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      emailVerified: emailVerified ?? this.emailVerified,
      creationTime: creationTime ?? this.creationTime,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
    );
  }
  
  static const empty = User(uid: '');
}

class ApiKey extends Equatable {
  final String key;
  final String? name;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final bool isActive;
  
  const ApiKey({
    required this.key,
    this.name,
    required this.createdAt,
    this.expiresAt,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [key, name, createdAt, expiresAt, isActive];
  
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }
  
  bool get isValid => isActive && !isExpired;
}
