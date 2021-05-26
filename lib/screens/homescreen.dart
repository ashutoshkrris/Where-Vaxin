import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:where_vaxin/components/search_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinCtrl = TextEditingController();
  DateTime date = DateTime.now();
  List _sessions = [];
  bool _isLoading = false;
  bool _searchDone = false;

  String getText() {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildForm(context),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _sessions.length == 0 && _searchDone
                    ? Text("No results")
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: _sessions.length,
                          itemBuilder: (context, index) => SearchTile(
                            name: _sessions[index]["name"],
                            address: _sessions[index]["address"],
                            date: _sessions[index]["date"],
                            availableCapacityDose1: _sessions[index]
                                    ["available_capacity_dose1"]
                                .toString(),
                            availableCapacityDose2: _sessions[index]
                                    ["available_capacity_dose2"]
                                .toString(),
                            slots: _sessions[index]["slots"],
                            minAgeLimit:
                                _sessions[index]["min_age_limit"].toString(),
                            vaccine: _sessions[index]["vaccine"],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.house,
                  color: Colors.deepPurple,
                ),
                labelText: "Pin Code",
                hintText: "Enter your Pin Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(42.0)),
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    style: BorderStyle.solid,
                    width: 4.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(42.0)),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(42.0)),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your Pin Code";
                } else if (value.length != 6) {
                  return "Please enter a valid Pin Code";
                }
                return null;
              },
              controller: _pinCtrl,
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Select Date",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => pickDate(context),
                    child: FittedBox(
                      child: Text(
                        getText(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => searchPin(_pinCtrl.text, getText()),
              child: Text(
                "Search",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(120, 50),
                elevation: 10,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                primary: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchPin(String pincode, String date) async {
    FocusManager.instance.primaryFocus!.unfocus();
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      var baseUrl = "https://cdn-api.co-vin.in/api";
      var apiUrl = Uri.parse(
          "$baseUrl/v2/appointment/sessions/public/findByPin?pincode=$pincode&date=$date");
      var response = await http.get(apiUrl);
      setState(() {
        _isLoading = false;
        _sessions = jsonDecode(response.body)["sessions"];
        _searchDone = true;
      });
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (newDate == null) return;
    setState(() => date = newDate);
  }
}
