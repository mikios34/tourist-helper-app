import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tourist_helper/bloc/user_bloc.dart';
import 'package:flutter_tourist_helper/bloc/user_event.dart';
import 'package:flutter_tourist_helper/bloc/user_state.dart';
import 'package:flutter_tourist_helper/models/models.dart';
import 'package:flutter_tourist_helper/screens/places_list.dart';
import 'package:flutter_tourist_helper/screens/user_screens/signup.dart';

import '../place_routes.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  final UserArgument args;
  LoginPage({this.args});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  //FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  _showerrormessega() {
    //SnackBar err =
    _globalKey.currentState.showSnackBar(SnackBar(content: Text("error")));
  }

  bool _loggedin = false;
  _login(ctx) async {
    setState(() {
      _loggedin = true;
    });

    final UserEvent loginevent =
        UserLogin(User(email: "haylemikaeltefera@gmail.com", password: "123456"));
    //print("Workinfffffggggggggggggggggggggggggggggggggg");
    BlocProvider.of<UserBloc>(ctx).add(loginevent);
    print("Workinfffffggggggggggggggggggggggggggggggggg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserOperationFailure) {
            _showerrormessega();

            print("Nope");
          }
          if (state is UsersLoadSuccess) {
            Navigator.pushNamed(context, PlacesList.routeName);
            print("yess");
          }
        },
        builder: (context, state) {
          return _loginform(context);
        },
      ),
    );
  }

  Widget _loginform(context) {
    return Form(
      child: ListView(
        children: [
          Icon(Icons.login, size: 180, color: Colors.white),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: _emailcontroller,
              decoration: InputDecoration(
                hintText: "Email Or Phone Number",
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.white.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: _passwordcontroller,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
                prefixIcon: Icon(
                  Icons.lock_open,
                  color: Colors.white.withOpacity(0.5),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: FlatButton(
              disabledColor: Colors.white.withOpacity(0.5),
              splashColor: Colors.white,
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed:
                  // _loggedin == true ? null :
                  () => _login(context),
              child: Text(
                "Log In",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
          FlatButton(
            splashColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, SignUp.routeName);
              //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx){
              //return VotersPage();
              //return SignUp();
              //return FeedsPage();
              //return VoterPage();
              //return SignUp();
              //return HomeScreen();
              //}));
            },
            child: Text(
              "Don't Have An Account? Sign Up Here",
              style: TextStyle(
                color: Colors.white.withOpacity(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
