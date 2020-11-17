// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecUser _$DecUserFromJson(Map<String, dynamic> json) {
  return DecUser()
    ..login = json['login'] as String
    ..id = json['id'] as num
    ..avatar_url = json['avatar_url'] as String
    ..url = json['url'] as String
    ..type = json['type'] as String
    ..site_admin = json['site_admin'] as bool
    ..name = json['name'] as String
    ..company = json['company'] as String
    ..blog = json['blog'] as String
    ..location = json['location'] as String
    ..email = json['email'] as String
    ..hireable = json['hireable'] as bool
    ..bio = json['bio'] as String
    ..public_repos = json['public_repos'] as num
    ..public_gists = json['public_gists'] as num
    ..followers = json['followers'] as num
    ..following = json['following'] as num
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..pastoralZone = json['pastoralZone'] as String
    ..pastoralGroup = json['pastoralGroup'] as String
    ..pastoralRole = json['pastoralRole'] as String
    ..certifiedMember = json['certifiedMember'] as bool
    ..imageLocalPath = json['imageLocalPath'] as String
    ..imageNetworkPath = json['imageNetworkPath'] as String
    ..total_private_repos = json['total_private_repos'] as num
    ..owned_private_repos = json['owned_private_repos'] as num;
}

Map<String, dynamic> _$DecUserToJson(DecUser instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatar_url,
      'url': instance.url,
      'type': instance.type,
      'site_admin': instance.site_admin,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'hireable': instance.hireable,
      'bio': instance.bio,
      'public_repos': instance.public_repos,
      'public_gists': instance.public_gists,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pastoralZone': instance.pastoralZone,
      'pastoralGroup': instance.pastoralGroup,
      'pastoralRole': instance.pastoralRole,
      'certifiedMember': instance.certifiedMember,
      'imageLocalPath': instance.imageLocalPath,
      'imageNetworkPath': instance.imageNetworkPath,
      'total_private_repos': instance.total_private_repos,
      'owned_private_repos': instance.owned_private_repos
    };
