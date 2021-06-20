import 'package:clup/controller/api/storeController.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/pages/bookingList/bookingList.dart';
import 'package:clup/view/pages/details/components/button.dart';
import 'package:clup/view/pages/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../homepage_theme.dart';

String _setDate = "";
int idUser = 0;

class DateTimePicker extends StatefulWidget {
  final Store store;

  DateTimePicker(this.store);

  @override
  _DateTimePickerState createState() => _DateTimePickerState(this.store);
}

class _DateTimePickerState extends State<DateTimePicker> {
  final Store store;
  StoreApi storeApi = new StoreApi();
  int statusCode;

  _DateTimePickerState(this.store);

  double _height;
  double _width;

  String _setTime;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        final df = new DateFormat('dd-MM-yyyy');
        final dfSql = new DateFormat('yyyy-MM-dd');
        _setDate = dfSql.format(selectedDate);
        print(_setDate);
        _dateController.text = df.format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        String formattedTime = DateFormat.Hm().format(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute));
        _timeController.text = formattedTime;
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _setDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formatted = DateFormat.Hm().format(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute));

    _timeController.text = formatted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return ListView(
      children: [
        TopRoundedContainer(
          color: HomepageTheme.buildLightTheme().primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  child: Image.network(
                store.imageUrl,
                scale: 0.7,
              )),
              Center(
                child: Text("\n" + store.city + ", " + store.address + "\n",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text("Seleziona la data",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        width: _width / 2,
                        height: _height / 15,
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextFormField(
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _dateController,
                          onSaved: (String val) {
                            _setDate = val;
                          },
                          decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.only(top: 0.0)),
                        ),
                      ),
                    ),
                    Divider(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    Text("Seleziona l'orario",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: _width / 2,
                        height: _height / 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextFormField(
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                          onSaved: (String val) {
                            _setTime = val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController,
                          decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.all(5)),
                        ),
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: Colors.transparent,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      child: DefaultButton(
                        text: "Prenota",
                        press: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool ok = prefs.getBool('login');
                          idUser = prefs.getInt("idUser");
                          print(idUser);
                          if (prefs.getBool('login') == null ||
                              !prefs.getBool('login')) {
                            print("NO");
                          } else {
                            bool okCheck = checkDateTime(
                                _setDate, _timeController.text);
                            if (!okCheck) {
                              Fluttertoast.showToast(
                                  msg:
                                  "Errore durante l'inserimento della data.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            else
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text(
                                          'Conferma di prenotazione'),
                                      content: const Text(
                                          'Sei sicuro di voler prenotare per il giorno selezionato?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () async {
                                            statusCode = await storeApi.booking(
                                                _setDate,
                                          _timeController.text,
                                          idUser.toString(),
                                          store.idStore);
                                      if (statusCode == 200) {
                                        Fluttertoast.showToast(
                                            msg:
                                            "Prenotazione effettuata con successo",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.SNACKBAR,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0);

                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                            "Errore durante la prenotazione. Riprovare",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.SNACKBAR,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingList()), (
                                                Route<dynamic> route) => false);
                                    },
                                    child: const Text('SI',
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'NO'),
                                    child: const Text(
                                      'NO',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                                  ),
                            );
                          }
                        },
                      ),
                    ),
                    Divider(height: 30, color: Colors.transparent,)
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

bool checkDateTime(String date, String time) {
  //TODO: Manca controllo sul minuto dell'orario.
  DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
  int hour = int.parse(time.substring(0, 2));
  DateTime t = new DateTime(
      tempDate.year, tempDate.month, tempDate.day, hour, 30);
  if (t.isBefore(DateTime.now()))
    return false;
  else
    return true;
}
