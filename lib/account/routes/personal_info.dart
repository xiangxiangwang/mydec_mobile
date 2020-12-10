
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/account/services/user_service.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/funs.dart';
import 'package:mydec/common/google_sign_in.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/sunday_service/models/sunday_service_menu.dart';

import '../../common/web_view_page.dart';



class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {

  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();

  GlobalKey _formKey = new GlobalKey<FormState>();

  DecUser _currentUser = Global.getCurrentUser();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text(DecLocalizations.of(context).personalInfo)),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody() {
    _firstnameController.text = _currentUser.firstName;
    _lastnameController.text = _currentUser.lastName;
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: _firstnameController,
                  decoration: InputDecoration(
                    labelText: DecLocalizations.of(context).firstName,
                    prefixIcon: Icon(Icons.person),
                  ),
                  // 校验用户名（不能为空）
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : DecLocalizations.of(context).firstNameRequired;
                  }),
              TextFormField(

                  controller: _lastnameController,
                  decoration: InputDecoration(
                    labelText: DecLocalizations.of(context).lastName,
                    prefixIcon: Icon(Icons.person),
                  ),
                  // 校验用户名（不能为空）
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : DecLocalizations.of(context).lastNameRequired;
                  }),
              Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: Row(
                      children: <Widget>[

                        Text(DecLocalizations.of(context).pastoralZone + ":"),
                        Text(_currentUser.pastoralZone == null ? "N/A" : _currentUser.pastoralZone),

                      ]
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: Row(
                      children: <Widget>[

                        Text(DecLocalizations.of(context).pastoralGroup + ":"),
                        Text(_currentUser.pastoralGroup == null ? "N/A" : _currentUser.pastoralGroup),

                      ]
                  )),
              Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Row(
                    children: <Widget>[

                      Text(DecLocalizations.of(context).shepherdPosition + ":"),
                      Text(_currentUser.shepherdPosition == null ? "N/A" : _currentUser.shepherdPosition),

                    ]
                )),
              Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: Row(
                      children: <Widget>[

                        Text(DecLocalizations.of(context).churchPosition + ":"),
                        Text(_currentUser.churchPosition == null ? "N/A" : _currentUser.churchPosition),

                      ]
                  )),
                Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: _currentUser.certifiedMember,
                            activeColor: Colors.blue, //选中时的颜色
                            onChanged: null

                          ),
                          Text(DecLocalizations.of(context).certifiedMember),

                        ]
              )),
              Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: Row(
                      children: <Widget>[
                        Checkbox(
                            value: _currentUser.fullTimeEmployee,
                            activeColor: Colors.blue, //选中时的颜色
                            onChanged: null

                        ),
                        Text(DecLocalizations.of(context).fullTimeEmployee),

                      ]
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onSave,
                    textColor: Colors.white,
                    child: Text(DecLocalizations.of(context).save),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }
  _onSave(){
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      try {
        _currentUser.firstName = _firstnameController.text;
        _currentUser.lastName =  _lastnameController.text;
        UserService.persistUser(_currentUser);
        Global.setCurrentUser(_currentUser);

      } catch (e) {
        //登录失败则提示

      } finally {
        // 隐藏loading框
        Navigator.of(context).pop();

        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
              title: new Text(DecLocalizations.of(context).result),
              content: new Text(DecLocalizations.of(context).dataSaved),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));

      }


    }
  }

}

