import 'package:firebase_project/screens/loginScreen.dart';
import 'package:firebase_project/screens/resgisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import '../widgets/my_btn.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'WelcomeScreen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('20');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /*decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gradient: LinearGradient(colors: <Color>[
                  Color(0xff014531),
                  Color(0xFF1c8164),
                  Colors.green,
                ]),
              ),*/
        decoration: BoxDecoration(
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
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FlutterLogo(
                size: 150,
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
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: ((value) => {}),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter Your Email",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              welcomeBtn(
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
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: ListTile(
                        onTap: _openCountryPickerDialog,
                        title: _buildDialogItem(_selectedDialogCountry),
                      ),
                    ),
                  ),
                  Text("data"),
                ],
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
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
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
