import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class DecUser {
    DecUser();

    String login;
    num id;
    String avatar_url;
    String url;
    String type;
    bool site_admin;
    String name;
    String company;
    String blog;
    String location;
    String email;
    bool hireable;
    String bio;
    num public_repos;
    num public_gists;
    num followers;
    num following;
    String created_at;
    String updated_at;
    num total_private_repos;
    num owned_private_repos;

    String firstName;
    String lastName;
    //牧区
    String pastoralZone;
    //小家
    String pastoralGroup;
    //教会职份
    String churchPosition;
    //牧养职份
    String shepherdPosition;
    // 是否全职同工
    bool fullTimeEmployee;
    // 是否认证用户
    bool certifiedMember;
    String uid;


    String imageLocalPath;
    String imageNetworkPath;


    factory DecUser.fromJson(Map<String,dynamic> json) => _$DecUserFromJson(json);
    Map<String, dynamic> toJson() => _$DecUserToJson(this);
}
