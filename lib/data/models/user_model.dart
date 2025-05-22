import 'package:football_live_app/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool isAnonymous = false,
    bool emailVerified = false,
    DateTime? creationTime,
    DateTime? lastSignInTime,
  }) : super(
          uid: uid,
          email: email,
          displayName: displayName,
          photoUrl: photoUrl,
          isAnonymous: isAnonymous,
          emailVerified: emailVerified,
          creationTime: creationTime,
          lastSignInTime: lastSignInTime,
        );

  /// Creates an empty user model for stub implementations
  factory UserModel.empty() {
    return const UserModel(
      uid: 'stub-user-id',
      email: 'stub@example.com',
      displayName: 'Stub User',
      isAnonymous: true,
    );
  }

  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    if (firebaseUser == null) return UserModel.empty();

    return UserModel(
      uid: firebaseUser.uid ?? '',
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      isAnonymous: firebaseUser.isAnonymous,
      emailVerified: firebaseUser.emailVerified,
      creationTime: firebaseUser.metadata?.creationTime,
      lastSignInTime: firebaseUser.metadata?.lastSignInTime,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      isAnonymous: json['isAnonymous'] ?? false,
      emailVerified: json['emailVerified'] ?? false,
      creationTime: json['creationTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['creationTime'])
          : null,
      lastSignInTime: json['lastSignInTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastSignInTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isAnonymous': isAnonymous,
      'emailVerified': emailVerified,
      'creationTime': creationTime?.millisecondsSinceEpoch,
      'lastSignInTime': lastSignInTime?.millisecondsSinceEpoch,
    };
  }

  @override
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isAnonymous,
    bool? emailVerified,
    DateTime? creationTime,
    DateTime? lastSignInTime,
  }) {
    return UserModel(
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
}

class ApiKeyModel extends ApiKey {
  const ApiKeyModel({
    required String key,
    String? name,
    required DateTime createdAt,
    DateTime? expiresAt,
    bool isActive = true,
  }) : super(
          key: key,
          name: name,
          createdAt: createdAt,
          expiresAt: expiresAt,
          isActive: isActive,
        );

  factory ApiKeyModel.fromJson(Map<String, dynamic> json) {
    return ApiKeyModel(
      key: json['key'] ?? '',
      name: json['name'],
      createdAt: json['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
          : DateTime.now(),
      expiresAt: json['expiresAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['expiresAt'])
          : null,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'expiresAt': expiresAt?.millisecondsSinceEpoch,
      'isActive': isActive,
    };
  }
}
