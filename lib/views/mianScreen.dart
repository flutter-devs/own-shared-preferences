import 'package:customDb/dataBase/coreDb.dart';
import 'package:customDb/views/dataScreen.dart';
import 'package:customDb/widgets/customTextField.dart';
import 'package:customDb/widgets/textButton.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String key;
  String value;
  String keyToDelte;
  Map data;

  showInitialData() async {
    data = await CoreDb.instance().getData();
    setState(() {});
  }

  removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  @override
  void initState() {
    showInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              customField(
                getData: (val) {
                  key = val;
                },
                hintText: " key",
              ),
              SizedBox(
                height: 20,
              ),
              customField(
                getData: (val) {
                  value = val;
                },
                hintText: " value",
              ),
              SizedBox(
                height: 20,
              ),
              textButton(
                () async {
                  removeFocus();

                  CoreDb.instance().writeData({key: value});
                  data = await CoreDb.instance().getData();
                  setState(() {});
                },
                "Load",
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
                height: 50,
              ),
              customField(
                getData: (val) {
                  keyToDelte = val;
                },
                hintText: "Enter key to delete",
              ),
              SizedBox(
                height: 10,
              ),
              Builder(
                builder: (context) => textButton(() {
                  removeFocus();
                  CoreDb.instance().deleteData(
                    keyToDelte,
                    () async {
                      data = await CoreDb.instance().getData();
                      setState(() {});
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Deleted $keyToDelte")));
                    },
                    () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("key :$keyToDelte dosent exist")));
                    },
                  );
                }, "Delte"),
              ),
              Text(
                data.toString() ?? "",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
