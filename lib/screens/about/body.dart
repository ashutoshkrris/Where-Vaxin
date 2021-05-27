import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:where_vaxin/components/show_alert.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({Key? key}) : super(key: key);

  final String title = "Where's Vaxin?";
  final String desc1 =
      "Where's Vaxin is an unofficial app which can help you find appointment availabilty and download vaccination certificates.\nIt uses Co-WIN Public APIs provided by API Setu to fetch data about the slots on selected date.\nAs per the new API guidelines : ";
  final String desc2 =
      "The appointment availability data is cached and may be upto 30 minutes old.Further, these APIs are subject to a rate limit of 100 API calls per 5 minutes per IP.";
  final String desc3 =
      "Please use the official website for booking slots and get your self vaccinated if you haven't yet. For further reference, visit the official documentation.";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/images/icon.png"),
              height: 150,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                desc1,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Text(
              desc2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                desc3,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultBtn(
                  text: 'Contact Me',
                  onPressed: () => _launchURL(context,
                      "mailto:contact@ashutoshkrris.tk?subject=Where%20Vaxin"),
                ),
                DefaultBtn(
                  text: 'Github',
                  onPressed: () => _launchURL(
                      context, "https://github.com/ashutoshkrris/Where-Vaxin"),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Keep Calm and Follow Guidelines",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async =>
      await canLaunch(url)
          ? await launch(url)
          : showAlert(
              context, AlertType.error, 'ERROR', "Couldn't launch the URL");
}

class DefaultBtn extends StatelessWidget {
  const DefaultBtn({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
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
  }
}
