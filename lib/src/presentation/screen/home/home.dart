import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../resources.dart';
import '../../route/model.dart';
import '../widget/search_bar.dart';
import 'widget/category_card.dart';

class HomeScreen extends StatelessWidget {
  static RouteConfig get route => RouteConfig(
        path: '/',
        builder: () => HomeScreen(),
      );

  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = EdgeInsets.only(
      left: R.dimen.horizontalPadding + MediaQuery.of(context).padding.left,
      right: R.dimen.horizontalPadding + MediaQuery.of(context).padding.right,
    );

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: R.color.white,
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: horizontalPadding.copyWith(top: 117.0),
              sliver: SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: -100.0,
                      top: -170.0,
                      child: Opacity(
                        opacity: 0.05,
                        child: ImageIcon(
                          AssetImage(
                            R.image.pokeball,
                          ),
                          size: 250.0,
                        ),
                      ),
                    ),
                    Text(
                      'What pokemon\nare you looking for?',
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: horizontalPadding + EdgeInsets.symmetric(vertical: 40.0),
              sliver: SliverToBoxAdapter(
                child: SearchBar(),
              ),
            ),
            SliverPadding(
              padding: horizontalPadding,
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 720 ? 3 : 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 2.58,
                ),
                delegate: SliverChildListDelegate(
                  [
                    CategoryCard(
                      label: 'Pokedex',
                      color: R.color.puertoRico,
                      shadowColor: R.color.shamrock,
                    ),
                    CategoryCard(
                      label: 'Moves',
                      color: R.color.salmon,
                      shadowColor: R.color.bittersweet,
                    ),
                    CategoryCard(
                      label: 'Abilities',
                      color: R.color.malibu,
                      shadowColor: R.color.summerSky,
                    ),
                    CategoryCard(
                      label: 'Items',
                      color: R.color.kournikova,
                      shadowColor: R.color.creamCan,
                    ),
                    CategoryCard(
                      label: 'Locations',
                      color: R.color.affair,
                      shadowColor: R.color.deepLilac,
                    ),
                    CategoryCard(
                      label: 'Type Charts',
                      color: R.color.coralTree,
                      shadowColor: R.color.myPink,
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: horizontalPadding.copyWith(top: 20.0),
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}