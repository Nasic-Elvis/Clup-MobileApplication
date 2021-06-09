import 'package:clup/bloc/category/category_bloc.dart';
import 'package:clup/bloc/category/category_event.dart';
import 'package:clup/bloc/category/category_state.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categories extends StatelessWidget {
  SizeConfig sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": FontAwesomeIcons.home, "text": "Tutti"},
      {"icon": FontAwesomeIcons.building, "text": "Attività"},
      {"icon": FontAwesomeIcons.shoppingCart, "text": "Supermercato"},
      {"icon": FontAwesomeIcons.heartbeat, "text": "Sanità"},
      {"icon": FontAwesomeIcons.wpforms, "text": "Servizi"},
      /*{"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},*/
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(12, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              switch (categories[index]["text"]) {
                case 'Tutti':
                  BlocProvider.of<CategoryBloc>(context).add(NoSelected());
                  break;
                case 'Attività':
                  BlocProvider.of<CategoryBloc>(context)
                      .add(SelectOtherActivity());
                  break;
                case 'Supermercato':
                  BlocProvider.of<CategoryBloc>(context)
                      .add(SelectSupermarket());
                  break;
                case 'Sanità':
                  BlocProvider.of<CategoryBloc>(context).add(SelectHealtCare());
                  break;
                case 'Servizi':
                  BlocProvider.of<CategoryBloc>(context).add(SelectServices());
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final GestureTapCallback press;

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: SizedBox(
        width: getProportionateScreenWidth(65, context),
        child: Column(
          children: [
            Container(
                padding:
                    EdgeInsets.all(getProportionateScreenWidth(15, context)),
                height: getProportionateScreenWidth(55, context),
                width: getProportionateScreenWidth(55, context),
                decoration: BoxDecoration(
                  color: HomepageTheme.buildLightTheme().primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon)),
            SizedBox(height: 5),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }
}
