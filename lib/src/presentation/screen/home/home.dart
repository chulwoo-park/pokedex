import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart' hide Page;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/di/module.dart';
import 'package:pokedex/src/presentation/news/event.dart';

import '../../../domain/common/page.dart';
import '../../../domain/news/entity.dart';
import '../../common/state.dart';
import '../../news/bloc.dart';
import '../../resources.dart';
import '../../route/model.dart';
import '../widget/overscroll_backdrop.dart';
import '../widget/search_bar.dart';
import 'widget/category_card.dart';

class HomeScreen extends StatelessWidget {
  static RouteConfig get route => RouteConfig(
        path: '/',
        builder: () => HomeScreen(),
      );

  final _newsBloc = NewsListBloc(getIt.get())..add(NewsListRequested());

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = EdgeInsets.only(
      left: R.dimen.horizontalPadding + MediaQuery.of(context).padding.left,
      right: R.dimen.horizontalPadding + MediaQuery.of(context).padding.right,
    );

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: OverScrollBackdrop(
        backgroundColor: R.color.white,
        topColor: R.color.white,
        bottomColor: R.color.whisper,
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
                padding:
                    horizontalPadding + EdgeInsets.symmetric(vertical: 40.0),
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
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Container(
                      height: 60.0,
                      color: R.color.whisper,
                    ),
                    Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: R.color.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                // hasScrollBody: false,
                child: Container(
                  color: R.color.whisper,
                  padding: horizontalPadding.copyWith(top: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pokémon News',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<NewsListBloc, AsyncState>(
                          cubit: _newsBloc,
                          builder: (context, state) {
                            if (state is Loading) {
                              return Center(
                                child: SizedBox.fromSize(
                                  size: Size.square(15.0),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        R.color.licorice),
                                    strokeWidth: 2.0,
                                  ),
                                ),
                              );
                            } else if (state is LoadSuccess<Page<News>>) {
                              if (state.data.items.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 60.0),
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Text('There is no news today.'),
                                    ),
                                  ),
                                );
                              } else {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (index == 0) {}

                                    final news = state.data.items[index];
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                news.title,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Opacity(
                                                opacity: 0.6,
                                                child: Text(
                                                  DateFormat('dd MMM yyyy')
                                                      .format(news.createdAt),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                        if (news.thumbnailUrl != null)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: Image.network(
                                              news.thumbnailUrl!,
                                              fit: BoxFit.cover,
                                              width: 110,
                                              height: 66,
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) => Divider(
                                    height: 32.0,
                                  ),
                                  itemCount: min(5, state.data.items.length),
                                );
                              }
                            }

                            // TODO error
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
