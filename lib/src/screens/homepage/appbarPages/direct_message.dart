import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_status_saver/src/controller/direct_message_controller.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage({Key? key}) : super(key: key);

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
  final _formkey = GlobalKey<FormState>();

  String coutryCode = '+29';
  String phoneNumber = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.09),
              child: Column(
                children: [
                  Text(
                    "Direct Message",
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: const Color.fromARGB(255, 5, 27, 7),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Message a number on whatsapp \nwithout saving it first!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(children: [
                      const SizedBox(
                        height: 45.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => phoneNumber = value,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: SizedBox(
                            height: 60,
                            width: 100,
                            child: CountryCodePicker(
                              onChanged: (CountryCode value) =>
                                  coutryCode = value.dialCode!,
                              initialSelection: 'IT',
                              favorite: const ['FR', '+234', '+1'],
                              alignLeft: false,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        maxLines: 5,
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          label: Text(
                              "Enter any mesage you wish to start the chat with."),
                        ),
                        onChanged: (value) => message = value,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () => DirectMessageController()
                              .sendMessage("$coutryCode$phoneNumber", message),
                          child: const Text(
                            "Send",
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
