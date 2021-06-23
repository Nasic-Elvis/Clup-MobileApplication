import 'dart:developer';

import 'package:clup/utils/values.dart' as Values;
import 'package:googleapis/calendar/v3.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  static const _scopes = const [CalendarApi.calendarScope];

  insert(title, startTime, endTime) {
    var _clientID = new ClientId(Values.ClientId.client, "");
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";
      Event event = Event(); // Create object of event

      event.summary = title;

      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = Values.ClientId.timeZone;
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = Values.ClientId.timeZone;
      end.dateTime = endTime;
      event.end = end;
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}