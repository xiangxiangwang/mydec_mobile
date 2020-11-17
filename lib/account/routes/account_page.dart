
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/account/services/user_service.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/google_sign_in.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/i10n/localization_intl.dart';


import 'dart:io';
import 'package:path/path.dart' as Path;


class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {


  DecUser _currentUser = Global.getCurrentUser();
  File _image;
  final picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(DecLocalizations.of(context).accountDisplay)),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAccountHeader(), //构建抽屉菜单头部
        Expanded(child: _buildAccountMenus()), //构建功能菜单
      ],
    );

    /***
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ListTile(
        dense: true,
        leading: Image(image: AssetImage("assets/images/youtube.png"), height: 35.0),
        title: Text("Youtube",        textScaleFactor: .9),
        subtitle:Text("click here to see youtube channel"),
        )]
        );
     **/
  }

  Widget _buildAccountHeader() {
      return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            // padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: InkWell(
                        onTap: () => _uploadImage(),
                        child: Container(
                          child: ClipOval(
                            clipper: _MyClipper(),
                            child: _currentUser.imageNetworkPath == null || _currentUser.imageNetworkPath == ""
                                ? Image(image: AssetImage("assets/images/empty_user.png"), height: 125.0, width: 125.0, fit: BoxFit.contain)
                                : Image.network(_currentUser.imageNetworkPath, height: 125.0, width: 125.0, fit: BoxFit.fitWidth),

                          ),
                        ),
                      )

                    ),
                    Text(
                      getCurrentUser(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _currentUser.firstName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "  "
                          ),
                          Text(
                            _currentUser.lastName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          _currentUser.certifiedMember == true  ?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                                children: <Widget>[
                                  Image(image: AssetImage("assets/images/certifiedMember.png"), height: 15.0),
                                  Text(DecLocalizations.of(context).certifiedMember),

                                ]
                              ),
                            )
                          :
                          Text(""),
                        ]

                    )
                  ],
                ),
              ]
            )

          ),
        );
  }


  // 构建菜单项
  Widget _buildAccountMenus() {

        return ListView(
          children: <Widget>[
            /***
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(DecLocalizations.of(context).theme),
              onTap: () => Navigator.pushNamed(context, "themes"),
            ),
                ***/
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(DecLocalizations.of(context).personalInfo),
              onTap: () => Navigator.pushNamed(context, "personalInfo"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(DecLocalizations.of(context).language),
              onTap: () => Navigator.pushNamed(context, "language"),
            ),
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: Text(DecLocalizations.of(context).logout),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    //退出账号前先弹二次确认窗
                    return AlertDialog(
                      content: Text(DecLocalizations.of(context).logoutTip),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(DecLocalizations.of(context).cancel),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text(DecLocalizations.of(context).yes),
                          onPressed: () {
                            // sign out and flow to the first page
                            signOutGoogle();
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );

  }

  Future _uploadImage() async {
    print("start to pick image");
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }
  Future _uploadFile() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_image.path)}');
    Task uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(()  {

          print('File Uploaded');
          storageReference.getDownloadURL().then((fileURL) {

            print('Download URL: $fileURL');
            // update the current user's account
            setState(() {
              _currentUser.imageNetworkPath = fileURL;
            });

            UserService.persistUser(_currentUser);
            Global.setCurrentUser(_currentUser);


        });
    });
  }
}


class _MyClipper extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTRB(0, 0, 120, 120);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
