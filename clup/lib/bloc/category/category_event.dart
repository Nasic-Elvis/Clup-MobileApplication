import 'package:flutter/cupertino.dart';

abstract class CategoryEvent {}

class NoSelected extends CategoryEvent {}

class SelectNearStore extends CategoryEvent {}

class SelectSupermarket extends CategoryEvent {}

class SelectHealtCare extends CategoryEvent {}

class SelectServices extends CategoryEvent {}

class SelectOtherActivity extends CategoryEvent {}

class SelectCity extends CategoryEvent {
  final String city;

  SelectCity({@required this.city});
}
