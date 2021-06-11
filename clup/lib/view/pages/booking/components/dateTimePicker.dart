import 'package:clup/controller/api/storeController.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/pages/details/components/button.dart';
import 'package:clup/view/pages/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String _setTime, _setDate;

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
        final df_sql = new DateFormat('yyyy-MM-dd');

        // _setDate = df_sql.format(selectedDate);
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
    _dateController.text = DateFormat.yMd().format(DateTime.now());
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
          color: Colors.greenAccent,
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
                      height: 50,
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
                          if (prefs.getBool('login') == null ||
                              !prefs.getBool('login')) {
                            print("NO");
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Conferma di prenotazione'),
                                content: const Text(
                                    'Sei sicuro di voler prenotare per il giorno selezionato?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      DateFormat df =
                                          new DateFormat('yyyy-mm-dd');
                                      statusCode = await storeApi.booking(
                                          "2020-05-04",
                                          _timeController.text,
                                          430,
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
                                      Navigator.pop(context, 'SI');
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
                    )
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
