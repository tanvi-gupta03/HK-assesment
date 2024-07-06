import 'dart:convert';

import 'package:assesment/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class loginpage extends StatefulWidget{
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController _controller= TextEditingController();
  TextEditingController _pass= TextEditingController();
  final String validemail = "eve.holt@reqres.in";
  final String validpassword = "pistol";
  bool _obscureText = true;
  void poppedup(String message){
     showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }
  void _visible() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  Future<void> login() async {
    final String email = _controller.text;
    final String password = _pass.text;
    final String apiurl = "https://reqres.in/api/login"; 
    if(email != validemail || password != validpassword){
      poppedup('Invalid Email or Password');
      return;
    }
    try {
      final response = await http.post(
        Uri.parse(apiurl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email, 
          "password": password, 
        }),
      );

      if (response.statusCode == 200) {
        
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Login successful: $data');
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      } else {
        
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        poppedup(errorData['error'] ?? 'Login failed');
       
      }
    } catch (error) {
      poppedup('An error occurred: $error');
      
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Image.network('data:image/jpeg;base64,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',
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
          
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 40, right: 40 ),
            child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                    ),
                    
                    ),SizedBox(height: 5,),
                    //emailinputfeild
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: _controller,
                          validator: (text){
                            if(text== null || text.isEmpty){
                              return 'email is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email,size: 30, weight: 100,color: Colors.black,),
                            labelText: 'Email Address',
                            labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w100,fontSize: 20),
                            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              
            ),
                            ),
                            
                          keyboardType: TextInputType.emailAddress,
          ),
  SizedBox(height: 13,),
  //passwordfeild
    TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
              controller: _pass,
              validator: (text){
                if(text== null || text.isEmpty){
                  return 'Password is empty';
                }
                return null;
              },
              
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock,size: 30, weight: 100,color: Colors.black,),
                suffixIcon:GestureDetector(
                  onTap: _visible,
                  child: Icon(_obscureText? Icons.visibility_off : Icons.visibility ,size: 30, weight: 100,color: Colors.black,)) ,
                labelText: 'Password',
                
                labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w100,fontSize: 20),
                border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  
),
                ),
                
              keyboardType: TextInputType.emailAddress,
            ), SizedBox(height: 13,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forget Password?',
                  style: TextStyle(
                     color: Colors.blue,
                     
                      fontSize: 20,
                  ),
                  
                ),
              ],
            ), SizedBox(height: 13,),
            Center(
              child: SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(onPressed: (){
                  login();
                }, child: Text(
                      'Login',
                      style: TextStyle(
                         color: Colors.white,
                         
                          fontSize: 20,
                      ),
                      
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 5,
                      shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  
                  ),
                    ),
                    ),
              ),
            ),
                  ],
                ),
              
            
          ),

        ],
      ),
    );

  }
}