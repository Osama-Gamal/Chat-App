import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';

import 'MainScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'WelcomeScreen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('20');

  late final _auth = FirebaseAuth.instance;
  late String numPhone;
  late final String countryCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        /*decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 192, 255, 110),
              Color.fromARGB(255, 140, 240, 149),
              Color.fromARGB(255, 116, 192, 139),
              Color.fromARGB(255, 36, 170, 81),
            ],
          ),
        ),*/
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/whatsapp.png",
                height: 130,
              ),
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Text(
                  "Message All",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "A new chat app that have a lot of new features",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              /* welcomeBtn(
                btnColor: Colors.blue,
                btnTxt: "Sign In",
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.screenRoute);
                },
              ),
              welcomeBtn(
                btnColor: Colors.orange,
                btnTxt: "Register",
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.screenRoute);
                },
              ),*/
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 55,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        child: ListTile(
                          onTap: _openCountryPickerDialog,
                          title: _buildDialogItem(_selectedDialogCountry),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: ((value) => {
                            numPhone = value,
                          }),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Your Phone Number",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                            //borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),

                          /*  borderRadius:
                                BorderRadius.all(Radius.circular(10))*/
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  //print('+' + _selectedDialogCountry.phoneCode + numPhone);
                  Navigator.pushNamed(context, HomeScreen.screenRoute);
                  //_auth.signInWithPhoneNumber(_selectedDialogCountry.phoneCode+numPhone);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Ink(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.green, Colors.lightGreen]),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text(
            "+${country.phoneCode}",
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(width: 8.0),
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your phone code'),
            onValuePicked: (Country country) =>
                setState(() => _selectedDialogCountry = country),
            itemBuilder: _buildDialogItem,
            /*priorityList: [
              CountryPickerUtils.getCountryByIsoCode('TR'),
              CountryPickerUtils.getCountryByIsoCode('US'),
            ],*/
          ),
        ),
      );
}
