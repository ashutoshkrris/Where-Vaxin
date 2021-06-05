import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/search_tile.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List _sessions = [];
  bool _isLoading = false;
  bool _searchDone = false;
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildForm(context),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                )
              : _sessions.length == 0 && _searchDone
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("No results found for this location"),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 500,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: _sessions.length,
                          itemBuilder: (context, index) => SearchTile(
                            name: _sessions[index]["name"],
                            address: _sessions[index]["address"],
                            date: _sessions[index]["date"],
                            availableCapacityDose1: _sessions[index]
                                ["available_capacity_dose1"],
                            availableCapacityDose2: _sessions[index]
                                ["available_capacity_dose2"],
                            slots: _sessions[index]["slots"],
                            minAgeLimit: _sessions[index]["min_age_limit"],
                            vaccine: _sessions[index]["vaccine"],
                          ),
                        ),
                      ),
                    ),
        ],
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
                suffixIcon: InkWell(
                  child: Icon(Icons.search),
                  onTap: () => pickDate(context),
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
          ],
        ),
      ),
    );
  }

  String getText() {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  void searchPin(String pincode, String date) async {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      var baseUrl = "https://cdn-api.co-vin.in/api";
      var apiUrl =
          "$baseUrl/v2/appointment/sessions/public/findByPin?pincode=$pincode&date=$date";
      var response = await Dio().get(apiUrl);
      setState(() {
        _isLoading = false;
        _sessions = response.data["sessions"];
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
    searchPin(_pinCtrl.text, getText());
  }
}
