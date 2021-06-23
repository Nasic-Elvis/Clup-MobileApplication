import 'package:clup/bloc/category/category_bloc.dart';
import 'package:clup/bloc/category/category_event.dart';
import 'package:clup/bloc/category/category_state.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:clup/utils/values.dart' as values;

import '../../../../utils/values.dart';

class Categories extends StatelessWidget {
  SizeConfig sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {values.Strings.home_components_categories_icon: FontAwesomeIcons.home, values.Strings.home_components_categories_text: AppLocalizations.of(context).homepage_categories_all},
      {values.Strings.home_components_categories_icon: FontAwesomeIcons.building, values.Strings.home_components_categories_text: AppLocalizations.of(context).homepage_categories_activity},
      {values.Strings.home_components_categories_icon: FontAwesomeIcons.shoppingCart, values.Strings.home_components_categories_text: AppLocalizations.of(context).homepage_categories_markets},
      {values.Strings.home_components_categories_icon: FontAwesomeIcons.wpforms, values.Strings.home_components_categories_text: AppLocalizations.of(context).homepage_categories_services},
      {values.Strings.home_components_categories_icon: FontAwesomeIcons.locationArrow, values.Strings.home_components_categories_text: AppLocalizations.of(context).homepage_categories_position}
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(12, context)),
      child:
          SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index][values.Strings.home_components_categories_icon],
              text: categories[index][values.Strings.home_components_categories_text],
              press: () {

                var homepage_categories_all;
                switch (categories[index][values.Strings.home_components_categories_text]) {
                  case "Categorie":
                    BlocProvider.of<CategoryBloc>(context).add(NoSelected());
                    break;
                  case "Attività":
                    BlocProvider.of<CategoryBloc>(context)
                        .add(SelectOtherActivity());
                    break;
                  case "Supermercati":
                    BlocProvider.of<CategoryBloc>(context)
                        .add(SelectSupermarket());
                    break;
                  case "Salute":
                    BlocProvider.of<CategoryBloc>(context)
                        .add(SelectHealtCare());
                    break;
                  case "Servizi":
                    BlocProvider.of<CategoryBloc>(context)
                        .add(SelectServices());
                    break;
                  case "Posizione":
                    BlocProvider.of<CategoryBloc>(context)
                        .add(SelectNearStore());
                }
              },
            ),
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
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is SupermarketState) {
                  return Container(
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(15, context)),
                      height: getProportionateScreenWidth(55, context),
                      width: getProportionateScreenWidth(55, context),
                      decoration: BoxDecoration(
                        color: widget.text == AppLocalizations.of(context).homepage_categories_markets
                            ? HomepageTheme().primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon));
                }
                if (state is OtherActivityState) {
                  return Container(
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(15, context)),
                      height: getProportionateScreenWidth(55, context),
                      width: getProportionateScreenWidth(55, context),
                      decoration: BoxDecoration(
                        color: widget.text == AppLocalizations.of(context).homepage_categories_activity
                            ? HomepageTheme().primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon));
                }
                if (state is ServicesState) {
                  return Container(
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(15, context)),
                      height: getProportionateScreenWidth(55, context),
                      width: getProportionateScreenWidth(55, context),
                      decoration: BoxDecoration(
                        color: widget.text == AppLocalizations.of(context).homepage_categories_services
                            ? HomepageTheme().primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon));
                }
                if (state is HealtCareState) {
                  return Container(
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(15, context)),
                      height: getProportionateScreenWidth(55, context),
                      width: getProportionateScreenWidth(55, context),
                      decoration: BoxDecoration(
                        color: widget.text == AppLocalizations.of(context).homepage_categories_health
                            ? HomepageTheme().primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon));
                }
                if (state is NoCategoryState) {
                  return Container(
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(15, context)),
                      height: getProportionateScreenWidth(55, context),
                      width: getProportionateScreenWidth(55, context),
                      decoration: BoxDecoration(
                        color: widget.text == AppLocalizations.of(context).homepage_categories_all
                            ? HomepageTheme().primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon));
                }
                if (state is NearStoreState) {
                  return Container(
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(15, context)),
                      height: getProportionateScreenWidth(55, context),
                      width: getProportionateScreenWidth(55, context),
                      decoration: BoxDecoration(
                        color: widget.text == AppLocalizations.of(context).homepage_categories_position
                            ? HomepageTheme().primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon));
                } else {
                  return Container(
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(15, context)),
                      height: getProportionateScreenWidth(55, context),
                      width: getProportionateScreenWidth(55, context),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon));
                }
              },
            ),
            SizedBox(height: 5),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.0),
            )
          ],
        ),
      ),
    );
  }
}
