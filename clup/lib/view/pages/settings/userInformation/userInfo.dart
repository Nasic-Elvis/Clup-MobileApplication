import 'package:clup/controller/repository/userRepository.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/main.dart';
import 'package:clup/model/user.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  UserInformation({Key key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  _UserInformationState();
  UserRepository _userRepository;

  @override
  void initState() {
    _userRepository = UserRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
          future: _userRepository.getUserInformation(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: Center(
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200.0),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF337CA0),
                                      Color(0xFF54D3C2)
                                    ],
                                  )),
                              child: Icon(
                                Icons.person,
                                size: 80.0,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Informazioni personali",
                          style: TextStyle(
                              color: Color(0xFF54D3C2),
                              letterSpacing: .5,
                              fontSize: 24),
                        ),
                        //Now let's create our first tab page
                        SizedBox(height: 24),
                        Container(
                            child: Column(children: <Widget>[
                          Container(
                            height: 60,
                            child: new ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: Color(0xFF54D3C2),
                              ),
                              title: const Text("Nome"),
                              subtitle: Text(snapshot.data.name),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 60,
                            child: new ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: Color(0xFF54D3C2),
                              ),
                              title: const Text("Cognome"),
                              subtitle: Text(snapshot.data.surname),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 60,
                            child: new ListTile(
                                leading: const Icon(
                                  Icons.email,
                                  color: Color(0xFF54D3C2),
                                ),
                                title: const Text("E-mail"),
                                subtitle: Text(snapshot.data.email)),
                          ),
                          SizedBox(height: 8),
                          Container(
                              height: 60,
                              child: new ListTile(
                                  leading: const Icon(
                                    Icons.contact_phone,
                                    color: Color(0xFF54D3C2),
                                  ),
                                  title: Text("Numero di telefono"),
                                  subtitle:
                                      Text(snapshot.data.telephoneNumber))),
                          SizedBox(height: 8),
                          Divider(height: 30.0, color: Colors.transparent),
                        ])),
                      ],
                    ),
                  ),
                );
              }
            }
          }),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HomepageTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
