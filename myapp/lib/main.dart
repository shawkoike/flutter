import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'regist.dart';

Future<void> main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAuthPage(),
    );
  }
}

class MyAuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {

  // 新規登録系
  String newUserEmail = '';
  String newUserPassword = '';

  // ログイン系
  String loginUserEmail = '';
  String loginUserPassword = '';

  // 共通
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
              const SizedBox(height: 18),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                // パスワードを隠す
                obscureText: true,
                onChanged: (String value) {
                  newUserPassword = value;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // メール・パスワードで登録
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result = await auth.createUserWithEmailAndPassword(
                      email: newUserEmail,
                      password: newUserPassword,
                    );

                    // 登録したユーザー情報
                    final User user = result.user!;
                    setState(() {
                      infoText = "登録OK：${user.email}";
                    });
                  } catch (e) {
                    setState(() {
                      infoText = "登録NG： ${e.toString()}";
                    });
                  }
                },
                child: Text("ユーザ登録"),
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  loginUserPassword = value;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result = await auth.signInWithEmailAndPassword(
                      email: loginUserEmail,
                      password: loginUserPassword,
                    );
                    final User user = result.user!;
                    setState(() {
                      infoText = "ログインOK：${user.email}";
                    });
                    Navigator.push<PageRoute>(
                      context,
                      MaterialPageRoute(builder: (context) => Regist())
                    );
                  } catch (e) {
                    infoText = "ログインNG：${e.toString()}";
                  }
                },
                child: Text("ログイン"),
              ),
              const SizedBox(height: 8),
              Text(infoText),
            ],
          ),
        ),
      ),
    );
  }
}
