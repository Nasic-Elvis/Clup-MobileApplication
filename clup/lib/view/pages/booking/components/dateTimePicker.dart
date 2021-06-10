import 'package:clup/model/store.dart';
import 'package:clup/view/pages/details/components/button.dart';
import 'package:clup/view/pages/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateTimePicker extends StatefulWidget {
  final Store store;

  DateTimePicker(this.store);

  @override
  _DateTimePickerState createState() => _DateTimePickerState(this.store);
}

//TODO: Create metodo formatDate per formattare la data nel formato dd-mm-yyyy
class _DateTimePickerState extends State<DateTimePicker> {
  final Store store;

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
        _dateController.text = DateFormat.yMd().format(selectedDate);
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
                            print("OK");
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
