import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pubdz_shopping/constants.dart';
import 'package:pubdz_shopping/screens/register_page.dart';
import 'package:pubdz_shopping/widgets/customBtn.dart';
import 'package:pubdz_shopping/widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loginFormLoading=false;
  String _loginEmail="";
  String _loginPassword="";
  FocusNode _passwordFocusNode;
  ////// Alert dialog
  Future<void>_alertDialogBuilder(String error)async{
    return showDialog(
        context:context,
        barrierDismissible: false,
        builder:(context){
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),

            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );

  }
  /////// Creating new account
  Future<String>_loginAccount()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _loginEmail, password: _loginPassword);
      return null;
    }on FirebaseAuthException catch (e){
      if(e.code=='weak-password'){
        return'The password provided is too weak.';

      }else if(e.code=='email-already-in-use'){
        return'The account already exists for that email';
      }
      return e.message;
    }catch(e){
      return e.toString();
    }
  }
  ///////   validation form
  void _submitForm()async{
    setState(() {
      _loginFormLoading=true;
    });
    String _createAccountFeedback=await _loginAccount();
    if(_createAccountFeedback!=null){
      _alertDialogBuilder(_createAccountFeedback);
      setState(() {
        _loginFormLoading=false;
      });
    }
  }

  @override
  void initState() {

    _passwordFocusNode=FocusNode();
    super.initState();
  }
  @override
  void dispose() {

    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('Welcome \n Login to your account',
                textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: <Widget>[
                  CustomInput(
                    hintText: 'Email',
                    onChange: (value){
                      _loginEmail=value;
                    },
                    onSubmitted: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: 'Password',
                    onChange: (value){
                      _loginPassword=value;
                    },
                    focusNode: _passwordFocusNode,
                    isObscured: true,
                    onSubmitted: (value){
                      _submitForm();
                    },
                  ),
                  CustomButton(
                    text: 'Login',
                    onPressed: (){
                      _submitForm();
                    },
                    outlines: false,
                      isLoading:_loginFormLoading,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: CustomButton(
                  text: 'Create new account',
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterPage()));
                  },
                  outlines: true,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
