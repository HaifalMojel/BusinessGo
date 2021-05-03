import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Verification_page.dart';
import 'package:flutter_app/sign_welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class sign_page extends StatefulWidget {
  @override
  _sign_pageState createState() => _sign_pageState();
}

class _sign_pageState extends State<sign_page> {

  bool showflag1 = false , showflag2 = false ,enabledFlag = false , validate1 = false , nameValidate = false , userNameValidate = false ,
  emailValidate = false , passwordValidate = false , login1 = false , login2 = false;
  double y1 = 0;
  final _textPssswordLogin = TextEditingController(text: kDebugMode?'Ha111_':null) , _textUserNameLogin = TextEditingController(text: kDebugMode?'HaifaM':null) ,
      _textPssswordNew = TextEditingController() , _textEmailNew = TextEditingController() ,
      _textName = TextEditingController() , _textUserName = TextEditingController() , resetemail = TextEditingController();

  final collRef = Firestore.instance.collection('BusinessOwner');

  FocusNode nameNode = FocusNode() , userNameNode = FocusNode() , emailNode = FocusNode() , passwordNode = FocusNode();

  String emailError = '          تأكد من صياغة البريد الالكتروني' , userNameError = '          اسم المستخدم موجود مسبقا' ;

  @override
  void dispose() {
    _textPssswordLogin.dispose();
    _textUserNameLogin.dispose();
    _textPssswordNew.dispose();
    _textEmailNew.dispose();
    _textName.dispose();
    _textUserName.dispose();
    nameNode.dispose();
    userNameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  void hideWidget1(){
    setState(() {
      showflag1 = false ;
      enabledFlag = false;
      showflag2 = true;
      login1 = false;
      login2 = true;
      y1 = MediaQuery.of(context).size.height/3;
    });
  }

  void hideWidget2(){
    setState(() {
      showflag1 = true;
      showflag2 = false ;
      enabledFlag = false;
      login1 = true;
      login2 = false;
      y1 = -MediaQuery.of(context).size.height/3;
    });
  }

  void showError1(){
    setState(() {
      validate1 = true;
    });
  }

  void showUserNameError(){
    setState(() {
      userNameValidate = true;
      userNameError = '          اسم المستخدم موجود مسبقا';
    });
  }

  alertResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تغيير الرقم السري"),
          content: Container(
            height: 70,
            child: Column(
              children: <Widget>[
                Text("ادخل بريدك الالكتروني"),
                TextField(
                  controller: resetemail,
                )
              ],
            ),
          ),
          actions: [
            FlatButton(
              textColor: Colors.black,
              onPressed: () async {
                bool flag = false;
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: resetemail.text);
                }catch(e){flag = true;}
                finally{Navigator.of(context).pop();
                if(flag)
                  alertResetErrorDialog(context);
                }
              },
              child: Text('ارسال'),
            ),
          ],
          elevation: 5,

        );
      },
    );
  }

  alertResetErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تغيير الرقم السري"),
          content: Container(
            height: 50,
            child: Column(
              children: <Widget>[
                Text(
                    "لا يمكن ارسال بريد الكتروني باستعاده الرقم السري" , style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('موافق'),
            ),
          ],
          elevation: 5,

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff8f8),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color(0xffb7e0ee),
              ),
            ),
            Transform.translate(
              offset: Offset(0.0, MediaQuery.of(context).size.height/2 - y1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2 + y1,
                decoration: BoxDecoration(
                  color: const Color(0xffeff8f8),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0.0, MediaQuery.of(context).size.height/2 - 50.5 - y1),
              child: Container(
                width: 101.0,
                height: 101.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xffeff8f8),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(101.0, MediaQuery.of(context).size.height/2 - 50.5 - y1),
              child: Container(
                width: 101.0,
                height: 101.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xffb7e0ee),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(110.0, MediaQuery.of(context).size.height/2 - 40 - y1),
              child: IconButton(
                onPressed: hideWidget2,
                iconSize: 70.0,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(8.0, MediaQuery.of(context).size.height/2 - 40 - y1),
              child: IconButton(
                onPressed: hideWidget1,
                iconSize: 70.0,
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.black54,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/1.72, MediaQuery.of(context).size.height/10),
              child: SizedBox(
                width: 156.0,
                child: Text(
                  'ادخل معلوماتك',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 22,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              maintainSize: enabledFlag,
              maintainAnimation: enabledFlag,
              maintainState: enabledFlag,
              visible: showflag1,
              child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/6.5),
              child: BlendMask(
                blendMode: BlendMode.srcOver,
                region: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/6.5)
                & Size(MediaQuery.of(context).size.width/1.3, 25.5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.3,
                  height: 25.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          height: 25.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              focusNode: nameNode,
                              onTap: (){
                                setState(() {
                                  if(userNameNode.hasFocus){
                                    if(_textUserName.text.length == 0){
                                      userNameNode.unfocus();
                                      userNameValidate = true;
                                      userNameError = '          اسم المستخدم يجب ان يحتوي علي اكثر من خمسة رموز';
                                    }
                                  }
                                  if(passwordNode.hasFocus){
                                    if(_textPssswordNew.text.length == 0){
                                      passwordNode.unfocus();
                                      passwordValidate = true;
                                    }
                                  }
                                  else if(emailNode.hasFocus){
                                    if(_textEmailNew.text.length == 0){
                                      emailNode.unfocus();
                                      emailValidate = true;
                                      emailError = '          تأكد من صياغة البريد الالكتروني';
                                    }
                                  }
                                });
                              },
                              controller: _textName,
                              onChanged: (value){
                                if(value.length < 3)
                                  nameValidate = true;
                                else
                                  nameValidate = false;
                              },
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: new InputDecoration(
                                  focusColor: Colors.blue,
                                  hintText: 'الاسم كامل',
                                  hintStyle: TextStyle(height: 0.0),
                                  errorText: nameValidate ? '          الاسم يجب ان يحتوي علي اكثر من حرفين' : null,
                                  errorStyle: TextStyle(height: 0.0),
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                    size: 30.0,
                                  )
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            ),
            Visibility(
              maintainSize: enabledFlag,
              maintainAnimation: enabledFlag,
              maintainState: enabledFlag,
              visible: showflag1,
              child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/4.6),
              child: BlendMask(
                blendMode: BlendMode.srcOver,
                region: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/4.6)
                & Size(MediaQuery.of(context).size.width/1.3, 25.5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.3,
                  height: 25.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          height: 25.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              focusNode: userNameNode,
                              onTap: (){
                                setState(() {
                                  if(passwordNode.hasFocus){
                                    if(_textPssswordNew.text.length == 0){
                                      passwordNode.unfocus();
                                      passwordValidate = true;
                                    }
                                  }
                                  else if(nameNode.hasFocus){
                                    if(_textName.text.length == 0){
                                      nameNode.unfocus();
                                      nameValidate = true;
                                    }
                                  }
                                  else if(emailNode.hasFocus){
                                    if(_textEmailNew.text.length == 0){
                                      emailNode.unfocus();
                                      emailValidate = true;
                                      emailError = '          تأكد من صياغة البريد الالكتروني';
                                    }
                                  }
                                });
                              },
                              onChanged: (value){
                                if(value.length < 6) {
                                  userNameValidate = true;
                                  userNameError = '          اسم المستخدم يجب ان يحتوي علي اكثر من خمسة رموز';
                                }
                                else
                                  userNameValidate = false;
                              },
                              controller: _textUserName,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: new InputDecoration(
                                  focusColor: Colors.blue,
                                  hintText: 'اسم المستخدم',
                                  hintStyle: TextStyle(height: 0.0),
                                  errorText: userNameValidate ? userNameError : null,
                                  errorStyle: TextStyle(height: 0.0),
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                    size: 30.0,
                                  )),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
            Visibility(
            maintainSize: enabledFlag,
            maintainAnimation: enabledFlag,
            maintainState: enabledFlag,
            visible: showflag1,
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/3.55),
              child: BlendMask(
                blendMode: BlendMode.srcOver,
                region: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/3.55)
                & Size(MediaQuery.of(context).size.width/1.3, 25.5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.3,
                  height: 25.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          height: 25.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              focusNode: emailNode,
                              onTap: (){
                                setState(() {
                                  if(userNameNode.hasFocus){
                                    if(_textUserName.text.length == 0){
                                      userNameNode.unfocus();
                                      userNameValidate = true;
                                      userNameError = '          اسم المستخدم يجب ان يحتوي علي اكثر من خمسة رموز';
                                    }
                                  }
                                  else if(nameNode.hasFocus){
                                    if(_textName.text.length == 0){
                                      nameNode.unfocus();
                                      nameValidate = true;
                                    }
                                  }
                                  else if(passwordNode.hasFocus){
                                    if(_textPssswordNew.text.length == 0){
                                      passwordNode.unfocus();
                                      passwordValidate = true;
                                    }
                                  }
                                });
                              },
                              controller: _textEmailNew,
                              onChanged: (value) {
                                if(value.length == 0){
                                  emailValidate = true;
                                  emailError = '          تأكد من صياغة البريد الالكتروني';
                                  return;
                                }
                                String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                RegExp regExp = new RegExp(pattern);
                                emailValidate = !regExp.hasMatch(value);
                                emailError = '          تأكد من صياغة البريد الالكتروني';
                              },
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: new InputDecoration(
                                  focusColor: Colors.blue,
                                  hintText: 'الايميل',
                                  hintStyle: TextStyle(height: 0.0),
                                  errorText: emailValidate ? emailError : null,
                                  errorStyle: TextStyle(height: 0.0),
                                  prefixIcon: const Icon(
                                    Icons.local_post_office,
                                    size: 30.0,
                                  )),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            ),
            Visibility(
              maintainSize: enabledFlag,
              maintainAnimation: enabledFlag,
              maintainState: enabledFlag,
              visible: showflag1,
              child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/2.87),
              child: BlendMask(
                blendMode: BlendMode.srcOver,
                region: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/2.87)
                & Size(MediaQuery.of(context).size.width/1.3, 25.5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.3,
                  height: 25.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          height: 25.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              focusNode: passwordNode,
                              controller: _textPssswordNew,
                              obscureText: true,
                              onTap: (){
                                setState(() {
                                  if(userNameNode.hasFocus){
                                    if(_textUserName.text.length == 0){
                                      userNameNode.unfocus();
                                      userNameValidate = true;
                                      userNameError = '          اسم المستخدم يجب ان يحتوي علي اكثر من خمسة رموز';
                                    }
                                  }
                                  else if(nameNode.hasFocus){
                                    if(_textName.text.length == 0){
                                      nameNode.unfocus();
                                      nameValidate = true;
                                    }
                                  }
                                  else if(emailNode.hasFocus){
                                    if(_textEmailNew.text.length == 0){
                                      emailNode.unfocus();
                                      emailValidate = true;
                                      emailError = '          تأكد من صياغة الايميل';
                                    }
                                  }
                                });
                              },
                              onChanged: (value) {
                                if(value.length == 0){
                                  passwordValidate = true;
                                  return;
                                }
                                String pattern;
                                bool isInvalid = false;
                                pattern = r"""[ `!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]""";
                                if(!RegExp(pattern).hasMatch(value)) isInvalid = true;
                                pattern = r"""[0-9]""";
                                if(!RegExp(pattern).hasMatch(value)) isInvalid = true;
                                pattern = r"""[a-z]""";
                                if(!RegExp(pattern).hasMatch(value)) isInvalid = true;
                                pattern = r"""[A-Z]""";
                                if(!RegExp(pattern).hasMatch(value)) isInvalid = true;
                                if(value.trim().length<8) isInvalid = true;
                                passwordValidate = isInvalid;
                              },
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: new InputDecoration(
                                  focusColor: Colors.blue,
                                  hintText: 'الرقم السري',
                                  hintStyle: TextStyle(height: 0.0),
                                  errorText: passwordValidate ? '          يجب ادخال حروف وارقام ورموز في الرقم السري' : null,
                                  errorStyle: TextStyle(height: 0.0),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    size: 30.0,
                                  )),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
            Visibility(
              maintainSize: enabledFlag,
              maintainAnimation: enabledFlag,
              maintainState: enabledFlag,
              visible: login1,
              child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/1.7, MediaQuery.of(context).size.height/2.3),
              child: DecoratedBox(
                decoration:
                ShapeDecoration(shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ), color: Colors.white54),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      buttonTheme: ButtonTheme.of(context).copyWith(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                child: OutlineButton(
                  onPressed: () async
                  {
                    nameNode.unfocus();
                    userNameNode.unfocus();
                    emailNode.unfocus();
                    passwordNode.unfocus();
                    if(_textName.text.length == 0)
                      setState(() {
                        nameValidate = true;
                      });
                    if(_textUserName.text.length == 0)
                      setState(() {
                        userNameValidate = true;
                        userNameError = '          اسم المستخدم يجب ان يحتوي علي اكثر من خمسة رموز';
                      });
                    if(_textEmailNew.text.length == 0)
                      setState(() {
                        emailValidate = true;
                        emailError = '          تأكد من صياغة الايميل';
                      });
                    if(_textPssswordNew.text.length == 0)
                      setState(() {
                        passwordValidate = true;
                      });
                    if(nameValidate || userNameValidate || emailValidate || passwordValidate)
                      return;
                    bool flag = false;
                    await collRef.getDocuments().then((QuerySnapshot snap){
                      snap.documents.forEach((DocumentSnapshot doc){
                        if(_textUserName.text.compareTo(doc.data['UserName']) == 0){
                          showUserNameError();
                          flag = true;
                        }
                      });
                    });
                    if(flag)
                      return;
                    try{
                      FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _textEmailNew.text, password: _textPssswordNew.text)).user;
                      if(user != null){
                        UserUpdateInfo userUpdate = UserUpdateInfo();
                        userUpdate.displayName = _textUserName.text;
                        user.updateProfile(userUpdate);
                        await collRef.document(user.uid).setData({'Email': _textEmailNew.text, 'FullName': _textName.text, 'UserName': _textUserName.text});
                        user.sendEmailVerification();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder:
                                (context) =>
                                verification_page(user)
                            )
                        );
                      }
                    }catch(e){
                      print(e);
                      if(nameValidate && userNameValidate && emailValidate && passwordValidate){
                        nameValidate = true;
                        userNameValidate = true;
                        emailValidate = true;
                        passwordValidate = true;
                      }
                      else{
                        if(e is PlatformException)
                          if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE'){
                            emailError = '          البريد الالكتروني مسجل مسبقا';
                            emailValidate = true;
                          }
                      }
                    }
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    'تسجيل الدخول' ,
                    style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(50, 0, 0, 50),
                          ),
                        ],
                        color: Colors.blue,
                        fontSize: 18
                    ),
                  ),
                ),
              ),
              ),
            ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/18),
              child: SizedBox(
                width: 180.0,
                child: Text(
                  'مستخدم جديد',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 30,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              maintainSize: enabledFlag,
              maintainAnimation: enabledFlag,
              maintainState: enabledFlag,
              visible: showflag2,
              child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/1.60 - y1),
              child: BlendMask(
                blendMode: BlendMode.srcOver,
                region: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/1.60 - y1)
                & Size(MediaQuery.of(context).size.width/1.3, 25.5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.3,
                  height: 25.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          height: 25.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: _textUserNameLogin,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: new InputDecoration(
                                  focusColor: Colors.blue,
                                  hintText: 'اسم المستخدم',
                                  hintStyle: TextStyle(height: 0.0),
                                  errorText: validate1 ? '          الرجاء ادخال اسم صحيح' : null,
                                  errorStyle: TextStyle(height: 0.0),
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                    size: 30.0,
                                  )),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
            Visibility(
              maintainSize: enabledFlag,
              maintainAnimation: enabledFlag,
              maintainState: enabledFlag,
              visible: showflag2,
              child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/1.40 - y1),
              child: BlendMask(
                blendMode: BlendMode.srcOver,
                region: Offset(MediaQuery.of(context).size.width/7.5, MediaQuery.of(context).size.height/1.40 - y1)
                & Size(MediaQuery.of(context).size.width/1.3, 25.5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.3,
                  height: 25.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          height: 25.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              obscureText: true,
                              controller: _textPssswordLogin,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: new InputDecoration(
                                  focusColor: Colors.blue,
                                  hintText: 'الرقم السري',
                                  hintStyle: TextStyle(height: 0.0),
                                  errorText: validate1 ? '          الرجاء ادخال رقم سري صالح' : null,
                                  errorStyle: TextStyle(height: 0.0),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    size: 30.0,
                                  )),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
            Visibility(
              maintainSize: enabledFlag,
              maintainAnimation: enabledFlag,
              maintainState: enabledFlag,
              visible: login2,
              child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/1.7, MediaQuery.of(context).size.height/1.27 - y1),
              child: DecoratedBox(
                decoration:
                ShapeDecoration(shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ), color: Colors.white54),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      buttonTheme: ButtonTheme.of(context).copyWith(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                  child: OutlineButton(
                    onPressed: () async
                    {
                      String em = '';
                      await collRef.getDocuments().then((QuerySnapshot snap){
                        snap.documents.forEach((DocumentSnapshot doc){
                          if(_textUserNameLogin.text.compareTo(doc.data['UserName']) == 0){
                            em = doc.data['Email'];
                          }
                        });
                      });
                      try{
                        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: em, password: _textPssswordLogin.text)).user;
                        if(user != null){
                          if(user.isEmailVerified) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    sign_welcome(user.uid)
                                )
                            );
                          }
                          else
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    verification_page(user)
                                )
                            );
                        }
                      }catch(e){
                        print(e);
                        _textUserNameLogin.text = "";
                        _textPssswordLogin.text = "";
                        showError1();
                      }
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Text(
                      'تسجيل الدخول' ,
                      style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(50, 0, 0, 50),
                            ),
                          ],
                          color: Colors.blue,
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ),
            Visibility(
              maintainSize: enabledFlag,
              maintainAnimation: enabledFlag,
              maintainState: enabledFlag,
              visible: login2,
              child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/1.15 - y1),
              child: SizedBox(
                width: 200.0,
                child: FlatButton(
                  child:Text(
                    'نسيت الرقم السري؟',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 16,
                      color: const Color(0xff01756a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  textTheme: ButtonTextTheme.primary,
                  onPressed: () {
                    alertResetDialog(context);
                  },
                ),
              ),
            ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/2 - y1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: Text(
                  'مستخدم سابق',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 30,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/1.4, MediaQuery.of(context).size.height/1.8 - y1),
              child: SizedBox(
                width: 77.0,
                child: Text(
                  'أهلا بك',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 22,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _svg_dde48x =
    '<svg viewBox="36.0 389.7 130.2 42.8" ><path transform="translate(128.5, 402.23)" d="M 22.57467842102051 30.27401351928711 C 22.07152938842773 30.27511215209961 21.58392333984375 30.08012771606445 21.19650077819824 29.7229118347168 L 8.276060104370117 17.74228286743164 C 7.360304832458496 16.89534378051758 7.234970092773438 15.38272190093994 7.99611759185791 14.36374759674072 C 8.757266044616699 13.3447732925415 10.11666488647461 13.20531177520752 11.03242111206055 14.05225086212158 L 22.57467842102051 24.78689193725586 L 34.116943359375 14.43563175201416 C 34.56182479858398 14.03363513946533 35.13236236572266 13.84554386138916 35.70224380493164 13.91300296783447 C 36.27212524414062 13.98046207427979 36.79433059692383 14.29790592193604 37.15324783325195 14.79505252838135 C 37.55191421508789 15.29311084747314 37.7459831237793 15.95352458953857 37.68876647949219 16.61744689941406 C 37.63155364990234 17.28136825561523 37.3282356262207 17.88871383666992 36.85177230834961 18.29339599609375 L 23.93132781982422 29.86667633056641 C 23.53276634216309 30.16743087768555 23.05510711669922 30.31084823608398 22.57467842102051 30.27401351928711 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 73.7, 420.0)" d="M 22.57467842102051 30.27401351928711 C 22.07152938842773 30.27511215209961 21.58392333984375 30.08012771606445 21.19650077819824 29.7229118347168 L 8.276060104370117 17.74228286743164 C 7.360304832458496 16.89534378051758 7.234970092773438 15.38272190093994 7.99611759185791 14.36374759674072 C 8.757266044616699 13.3447732925415 10.11666488647461 13.20531177520752 11.03242111206055 14.05225086212158 L 22.57467842102051 24.78689193725586 L 34.116943359375 14.43563175201416 C 34.56182479858398 14.03363513946533 35.13236236572266 13.84554386138916 35.70224380493164 13.91300296783447 C 36.27212524414062 13.98046207427979 36.79433059692383 14.29790592193604 37.15324783325195 14.79505252838135 C 37.55191421508789 15.29311084747314 37.7459831237793 15.95352458953857 37.68876647949219 16.61744689941406 C 37.63155364990234 17.28136825561523 37.3282356262207 17.88871383666992 36.85177230834961 18.29339599609375 L 23.93132781982422 29.86667633056641 C 23.53276634216309 30.16743087768555 23.05510711669922 30.31084823608398 22.57467842102051 30.27401351928711 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_80ue77 =
    '<svg viewBox="6.0 18.5 20.9 9.0" ><path transform="translate(0.0, -4.0)" d="M 26.8912353515625 31.5 L 26.8912353515625 28.5 C 26.8912353515625 25.1862907409668 24.55290412902832 22.5 21.66842651367188 22.5 L 11.22280883789062 22.5 C 8.338330268859863 22.5 5.999999046325684 25.18629264831543 6 28.50000190734863 L 6 31.5" fill="none" fill-opacity="0.5" stroke="#1b5070" stroke-width="1" stroke-opacity="0.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_1j36d2 =
    '<svg viewBox="10.4 4.5 12.0 12.0" ><path transform="translate(-1.55, 0.0)" d="M 24 10.5 C 24 13.8137092590332 21.3137092590332 16.5 18 16.5 C 14.68629264831543 16.5 12.00000095367432 13.8137092590332 12 10.50000095367432 C 12 7.186292171478271 14.68629264831543 4.5 18.00000190734863 4.500000953674316 C 21.3137092590332 4.500000953674316 24 7.186293601989746 24 10.50000190734863 Z" fill="none" fill-opacity="0.5" stroke="#1b5070" stroke-width="1" stroke-opacity="0.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_4rrg51 =
    '<svg viewBox="31.5 238.5 283.0 1.0" ><path transform="translate(31.5, 238.5)" d="M 0 0 L 283 0" fill="none" fill-opacity="0.22" stroke="#1b5070" stroke-width="1" stroke-opacity="0.22" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_4xnex9 =
    '<svg viewBox="322.0 215.0 26.0 20.0" ><path transform="translate(319.0, 209.0)" d="M 26.39857292175293 6 L 5.599841594696045 6 C 4.169928550720215 6 3.012999534606934 7.125 3.012999534606934 8.5 L 3 23.50000190734863 C 3 24.875 4.169928550720215 26.00000190734863 5.599841594696045 26.00000190734863 L 26.39857292175293 26.00000190734863 C 27.8284854888916 26.00000190734863 28.99841499328613 24.875 28.99841499328613 23.50000190734863 L 28.99841499328613 8.5 C 28.99841499328613 7.125 27.8284854888916 6 26.39857292175293 6 Z M 26.39857292175293 11 L 15.99920654296875 17.25 L 5.599841594696045 11 L 5.599841594696045 8.5 L 15.99920654296875 14.75000190734863 L 26.39857292175293 8.5 L 26.39857292175293 11 Z" fill="none" fill-opacity="0.5" stroke="#1b5070" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_31i9bb =
    '<svg viewBox="4.5 12.5 24.0 16.5" ><path transform="translate(0.0, -4.0)" d="M 7.166666507720947 16.5 L 25.83333396911621 16.5 C 27.30609321594238 16.5 28.49999809265137 17.8431453704834 28.49999809265137 19.5 L 28.49999809265137 30 C 28.49999809265137 31.6568546295166 27.30609321594238 33 25.83333396911621 33 L 7.166666507720947 33 C 5.693907737731934 33 4.5 31.6568546295166 4.499999523162842 30 L 4.499999523162842 19.5 C 4.499999523162842 17.8431453704834 5.693907737731934 16.5 7.166666984558105 16.5 Z" fill="none" fill-opacity="0.5" stroke="#1b5070" stroke-width="1" stroke-opacity="0.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_dexzm4 =
    '<svg viewBox="10.5 3.0 12.0 13.5" ><path  d="M 10.5 16.5 L 10.5 10.5 C 10.5 6.357865333557129 13.18629360198975 3 16.50000190734863 3.000000953674316 C 19.8137092590332 3.000000953674316 22.50000190734863 6.357866287231445 22.50000190734863 10.50000190734863 L 22.50000190734863 16.5" fill="none" fill-opacity="0.5" stroke="#1b5070" stroke-width="1" stroke-opacity="0.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
