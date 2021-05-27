import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:where_vaxin/components/pdf_view.dart';
import 'package:where_vaxin/components/show_alert.dart';

class CertificateBody extends StatefulWidget {
  const CertificateBody({Key? key}) : super(key: key);

  @override
  _CertificateBodyState createState() => _CertificateBodyState();
}

class _CertificateBodyState extends State<CertificateBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  final TextEditingController _benCtrl = TextEditingController();
  bool _otpSent = false;
  bool _otpConfirmed = false;
  bool _isLoading = false;
  var client = Dio(BaseOptions(baseUrl: "https://cdn-api.co-vin.in/api"));
  String txnId = "";
  String token = "";
  String progress = "";
  String _fileFullPath = "";

  Future<List<Directory>?> _getExternalStoragePath() {
    return pp.getExternalStorageDirectories(
        type: pp.StorageDirectory.documents);
  }

  Future _downloadAndSaveFile(String url, String filename) async {
    try {
      final dirList = await _getExternalStoragePath();
      final path = dirList![0].path;
      final file = File("$path/$filename");
      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(msg: "Downloading", max: 100);
      await client.download(url, file.path,
          options: Options(headers: {"authorization": "Bearer $token"}),
          onReceiveProgress: (rec, total) {
        setState(() {
          _isLoading = true;
          progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
          pd.update(msg: "Dowloading $progress", value: (rec ~/ total) * 100);
        });
      });
      pd.close();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfScreen(
            file: file,
            filename: filename,
          ),
        ),
      );
      _fileFullPath = file.path;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showAlert(context, AlertType.error, "ERROR",
          'Something went wrong while downloading the file!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Column(
            children: [
              buildPhoneField(),
              buildGenerateOTPBtn(),
              buildOTPField(),
              buildConfirmOTPBtn(),
              buildBeneficiaryField(),
              buildDownloadBtn()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPhoneField() {
    if (!_otpSent && !_otpConfirmed) {
      return TextFormField(
        decoration: InputDecoration(
          prefixText: "+91 ",
          suffixIcon: Icon(
            Icons.phone,
            color: Colors.deepPurple,
          ),
          labelText: "Mobile Number",
          hintText: "Enter your mobile number",
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
            return "Please enter your mobile number";
          } else if (value.length != 10) {
            return "Please enter a valid mobile number";
          }
          return null;
        },
        controller: _phoneCtrl,
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget buildOTPField() {
    if (_otpSent && !_otpConfirmed) {
      return TextFormField(
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.lock,
            color: Colors.deepPurple,
          ),
          labelText: "OTP",
          hintText: "Enter your OTP",
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
            return "Please enter your OTP";
          } else if (value.length != 6) {
            return "Please enter a valid OTP";
          }
          return null;
        },
        controller: _otpCtrl,
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget buildBeneficiaryField() {
    if (_otpSent && _otpConfirmed) {
      return TextFormField(
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.lock,
            color: Colors.deepPurple,
          ),
          labelText: "Beneficiary ID",
          hintText: "Enter your Beneficiary ID",
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
            return "Please enter your Beneficiary ID";
          } else if (value.length != 13) {
            return "Please enter a valid Beneficiary ID";
          }
          return null;
        },
        controller: _benCtrl,
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget buildGenerateOTPBtn() {
    if (!_otpSent && !_otpConfirmed) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: ElevatedButton(
          onPressed: () => generateOTP(),
          child: _isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  "Generate OTP",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(150, 50),
            elevation: 20,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            primary: Colors.deepPurple,
          ),
        ),
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget buildConfirmOTPBtn() {
    if (_otpSent && !_otpConfirmed) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: ElevatedButton(
          onPressed: () => confirmOTP(),
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
                  "Confirm OTP",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(150, 50),
            elevation: 20,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            primary: Colors.deepPurple,
          ),
        ),
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget buildDownloadBtn() {
    if (_otpSent && _otpConfirmed) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: ElevatedButton(
          onPressed: () {
            _downloadAndSaveFile(
                "/v2/registration/certificate/public/download?beneficiary_reference_id=${_benCtrl.text}",
                "${_benCtrl.text}.pdf");
            Text("Written $_fileFullPath");
          },
          child: Text(
            "Download",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(150, 50),
            elevation: 20,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            primary: Colors.deepPurple,
          ),
        ),
      );
    } else {
      return Container(height: 0);
    }
  }

  void generateOTP() async {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        var response = await client.post("/v2/auth/public/generateOTP",
            data: {"mobile": _phoneCtrl.text});

        setState(() {
          txnId = response.data["txnId"];
          _otpSent = true;
          _isLoading = false;
        });
        showAlert(context, AlertType.success, "OTP SENT",
            "An OTP has been sent you!");
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showAlert(context, AlertType.error, "ERROR",
            'Something went wrong while sending OTP!');
      }
    }
  }

  void confirmOTP() async {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        var otp = sha256.convert(utf8.encode(_otpCtrl.text)).toString();
        var response = await client.post("/v2/auth/public/confirmOTP",
            data: {"otp": otp, "txnId": txnId});

        setState(() {
          token = response.data["token"];
          _otpConfirmed = true;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showAlert(
            context, AlertType.error, "ERROR", 'Please enter correct OTP!');
      }
    }
  }
}
