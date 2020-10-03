import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_robinhood/blocs/crypto/crypto_bloc.dart';
import 'package:flutter_robinhood/styles/styles.dart';
import 'package:flutter_robinhood/widgets/free_stock_button.dart';
import 'package:flutter_robinhood/widgets/graph.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  double _offset = 0;
  List<bool> _selections = [
    true,
    false,
    false,
    false,
    false,
    false,
  ];

  _graphOption(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selections = _selections.map((_) => false).toList();
          _selections[index] = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              _selections[index] ? Styles.color_positive : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
          child: Text(
            text,
            style: TextStyle(
                color:
                    _selections[index] ? Colors.black : Styles.color_positive,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          setState(() => _offset = notification.metrics.pixels);
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: AnimatedOpacity(
                opacity: _offset > 50 ? 1 : 0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutQuad,
                child: Column(
                  children: [
                    Text(
                      "\$5,611.81",
                      style: Styles.textstyle_appbar_title,
                    ),
                    Text(
                      "Investing",
                      style: Styles.textstyle_appbar_subtitle,
                    )
                  ],
                ),
              ),
              elevation: 0,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 420,
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Investing",
                                style: Styles.textstyle_header,
                              ),
                              FreeStockButton(),
                            ],
                          ),
                          Text(
                            "\$5,611.81",
                            style: Styles.textstyle_header,
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                MdiIcons.arrowTopRight,
                                color: Styles.color_positive,
                                size: 20,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "\$15.76 (0.28%)",
                                style: Styles.textstyle_subheaderPositive,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "Today",
                                style: TextStyle(color: Styles.color_text),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                MdiIcons.arrowTopRight,
                                color: Colors.green,
                                size: 20,
                              ),
                              Text(
                                "\$12.57 (0.22%)",
                                style: Styles.textstyle_subheaderPositive,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "After-Hours",
                                style: TextStyle(color: Styles.color_text),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: LineChartSample2(
                        selected: _selections.indexWhere((e) => e == true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0, 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _graphOption("1D", 0),
                          _graphOption("1W", 1),
                          _graphOption("1M", 2),
                          _graphOption("3M", 3),
                          _graphOption("1Y", 4),
                          _graphOption("ALL", 5),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Buying Power",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$652.71",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBody(CryptoState state) {
    if (state is CryptoLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
        ),
      );
    } else if (state is CryptoLoaded) {
      return RefreshIndicator(
        color: Theme.of(context).accentColor,
        onRefresh: () async {
          context.bloc<CryptoBloc>().add(RefreshCoins());
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) =>
              _onScrollNotification(notification, state),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.coins.length,
            itemBuilder: (BuildContext context, int index) {
              final coin = state.coins[index];
              return ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${++index}",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                title: Text(
                  coin.fullName,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  coin.name,
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  "\$${coin.price.toStringAsFixed(4)}",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else if (state is CryptoError) {
      return Center(
        child: Text(
          "Error Loading Coins\nPlease check your connection",
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 18.0,
          ),
        ),
      );
    }
  }

  bool _onScrollNotification(ScrollNotification notif, CryptoLoaded state) {
    if (notif is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      context.bloc<CryptoBloc>().add(LoadMoreCoins(coins: state.coins));
    }

    return false;
  }
}
