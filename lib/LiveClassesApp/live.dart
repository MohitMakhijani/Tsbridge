import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ZeoLiveServices.dart';

class Live extends StatefulWidget {
  const Live({Key? key}) : super(key: key);

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  final _formKey = GlobalKey<FormState>();// Updated variable name to indicate host status
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Join Live Classes ",style:  GoogleFonts.abyssinicaSil(fontSize: 20,fontWeight: FontWeight.w700,)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 15.0),
                child: TextFormField(
                  controller: idController,
                  validator: (idController) {
                    if (idController!.isEmpty)
                      return "Please enter Id";
                    else{
                      return "Please enter Id";
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.perm_identity_outlined,
                    ),
                    contentPadding: EdgeInsets.all(25.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                    labelText: 'Enter Live Id',
                    labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    hintText: 'Enter Live Id',
                    hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.bottomCenter,child: FilledButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) {
                        return  LivePage(liveID:idController.text.toString(), isHost: false, );
                      },));
                  }, child: Text("Join")),),
                ),
              )
            ],
          ),
        ),
      ),
   
    );
  }
}
