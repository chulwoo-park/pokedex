import 'dart:math';

import 'package:flutter/material.dart' hide Page;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../di/module.dart';
import '../../../domain/common/page.dart';
import '../../../domain/news/entity.dart';
import '../../common/state.dart';
import '../../news/bloc.dart';
import '../../news/event.dart';
import '../../resources.dart';
import '../../route/model.dart';
import '../widget/overscroll_backdrop.dart';
import '../widget/search_bar.dart';
import 'widget/category_card.dart';

class HomeScreen extends StatefulWidget {
  static RouteConfig get route => RouteConfig(
        path: '/',
        builder: () => HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsListBloc _newsBloc;

  @override
  void initState() {
    super.initState();
    _newsBloc = NewsListBloc(getIt.get());
    _newsBloc.add(NewsListRequested());
  }

  @override
  void dispose() {
    _newsBloc.close();
    super.dispose();
  }

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
          body: RefreshIndicator(
            displacement: 80.0,
            onRefresh: () async {
              _newsBloc.add(NewsListRequested());
            },
            child: CustomScrollView(
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
                    padding: horizontalPadding,
                    child: BlocBuilder<NewsListBloc, AsyncState>(
                      cubit: _newsBloc,
                      builder: (context, state) {
                        final listPadding =
                            EdgeInsets.only(top: 38.0, bottom: 80.0);
                        if (state is Loading) {
                          return ListView(
                            padding: listPadding,
                            children: [
                              _NewsTitle(),
                              _NewsLoading(),
                            ],
                          );
                        } else if (state is LoadSuccess<Page<News>>) {
                          if (state.data.items.isEmpty) {
                            return ListView(
                              padding: listPadding,
                              children: [
                                _NewsTitle(),
                                _NewsEmpty(),
                              ],
                            );
                          } else {
                            return ListView.separated(
                              padding: listPadding,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return _NewsTitle();
                                }

                                final news = state.data.items[index - 1];
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
                              separatorBuilder: (context, index) {
                                if (index == 0) {
                                  return SizedBox(height: 32.0);
                                } else {
                                  return Divider(height: 32.0);
                                }
                              },
                              itemCount: min(5, state.data.items.length) + 1,
                            );
                          }
                        }

                        // TODO error
                        return ListView(
                          padding: listPadding,
                          children: [
                            _NewsTitle(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NewsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Pokémon News',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 20.0,
      ),
    );
  }
}

class _NewsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80.0),
      child: SizedBox.fromSize(
        size: Size.square(15.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(R.color.licorice),
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

class _NewsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 60.0),
        child: Opacity(
          opacity: 0.6,
          child: Text('There is no news today.'),
        ),
      ),
    );
  }
}
