class UserEntity{
  final String?name;
  String?email;
  String?career;
  List?followers;
  List?following;
  int?followerNumber;
  int?followingNumber;
  String?uid;
  String?userName;
  String?profileUrl;
  String?bio;
  String?password;
  int?postNumber;

  UserEntity({
      this.name,
      this.email,
      this.career,
      this.followers,
      this.following,
      this.followerNumber,
      this.followingNumber,
      this.uid,
      this.userName,
      this.profileUrl,
      this.bio,
      this.password,
      this.postNumber

  });
}