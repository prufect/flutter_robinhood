import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_robinhood/blocs/crypto/crypto_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  double _offset = 0;

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
                child: Text("Robinhood"),
              ),
              elevation: 0,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 400,
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
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                              FlatButton.icon(
                                color: Colors.greenAccent,
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.gift,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Free Stock",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "\$5,611.81",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.arrow_up_right,
                                color: Colors.green,
                              ),
                              Text(
                                "\$15.76 (0.28%)",
                                style: TextStyle(color: Colors.green),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "Today",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.arrow_up_right,
                                color: Colors.green,
                              ),
                              Text(
                                "\$12.57 (0.22%)",
                                style: TextStyle(color: Colors.green),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "After-Hours",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Text("Graph",
                              style: TextStyle(color: Colors.white)),
                        ),
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
