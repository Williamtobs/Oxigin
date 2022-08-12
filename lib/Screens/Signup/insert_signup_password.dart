import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Provider/auth_provider.dart';
import '../Login/login_screen.dart';
import '../Shared/text_button.dart';
import '../Shared/text_fields.dart';

class SignUpPasswordScreen extends ConsumerStatefulWidget {
  final String email;
  final String userName;
  final String age;
  final String gender;
  const SignUpPasswordScreen(
      {Key? key,
      required this.email,
      required this.userName,
      required this.age,
      required this.gender})
      : super(key: key);

  @override
  ConsumerState<SignUpPasswordScreen> createState() =>
      _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends ConsumerState<SignUpPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(authRepositoryProvider);
    final data = ref.watch(fireBaseAuthProvider);

    signUp() async {
      await model
          .signUpWithEmailAndPassword(
              widget.email, _passwordController.text, context)
          .whenComplete(() {
        model.authStateChange.listen((event) {
          print(data.currentUser!.uid);
          storeDetails(data.currentUser!.uid, widget.userName, widget.age,
              widget.email, widget.gender);
          if (event == null) {
            return;
          }
        });
      });
    }

    return Scaffold(
      backgroundColor: HexColor('ffffff'),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 100,
        // leading: Padding(
        //   padding: const EdgeInsets.only(top: 15),
        //   child: Image.asset('image/log.png', height: 52, width: 35),
        // ),
        backgroundColor: HexColor('ffffff'),
        elevation: 0,
        leadingWidth: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            width: MediaQuery.of(context).size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset('image/log.png', height: 52, width: 35),
              const SizedBox(
                height: 20,
              ),
              Text('Create An Account',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(18, 18, 18, 1))),
              const SizedBox(
                height: 10,
              ),
              Text('Please create an account to get more of Oxigin',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(18, 18, 18, 0.8))),
              const SizedBox(
                height: 30,
              ),
              Text('PASSWORD',
                  style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(18, 18, 18, 1))),
              const SizedBox(
                height: 5,
              ),
              AppTextField(
                hintText: 'Enter a strong password',
                controller: _passwordController,
                obscure: true,
              ),
              const SizedBox(
                height: 30,
              ),
              Text('RE-TYPE PASSWORD',
                  style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(18, 18, 18, 0.45))),
              const SizedBox(
                height: 5,
              ),
              AppTextField(
                hintText: 'Retype your password',
                controller: _confirmPasswordController,
                obscure: true,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Icon(Icons.cancel_outlined,
                      color: Color.fromRGBO(18, 18, 18, 1)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Password must include a number',
                      style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(18, 18, 18, 1)))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.check_circle_outline,
                      color: Color.fromRGBO(204, 204, 204, 1)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Password must include an alphabet',
                      style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(204, 204, 204, 1)))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.check_circle_outline,
                      color: Color.fromRGBO(204, 204, 204, 1)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Password must include a special character',
                      style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(204, 204, 204, 1)))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              AppTextButton(
                text: 'Proceed',
                onPressed: () {
                  signUp();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                  'Oxigin will send you members-only deals, and push notifications. You can opt out of '
                  'receiving these at any time in your account settings or directly from the '
                  'marketing notification.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(18, 18, 18, 0.56))),
              const Spacer(),
              Center(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(18, 18, 18, 0.56))),
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(18, 18, 18, 1),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                  ),
                ])),
              ),
              const SizedBox(
                height: 40,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

storeDetails(String userId, String fullName, String age, String email,
    String gender) async {
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  await ref.doc(userId).set({
    'id': userId,
    'full_name': fullName,
    'age': age,
    'email': email,
    'phone': gender,
  });
}

//fullname, age, mail, gender
