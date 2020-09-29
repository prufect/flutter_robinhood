import 'package:flutter/material.dart';
import 'package:flutter_robinhood/models/coin_model.dart';
import 'package:flutter_robinhood/repositories/crypto_respository.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cryptoRepo = CryptoRepository();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Robinhood"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Theme.of(context).primaryColor, Colors.grey[900]]),
        ),
        child: FutureBuilder(
          future: _cryptoRepo.getTopCoins(page: _page),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                ),
              );
            }

            final List<Coin> coins = snapshot.data;
            return RefreshIndicator(
              color: Theme.of(context).accentColor,
              onRefresh: () async => setState(() => _page = 0),
              child: ListView.builder(
                itemCount: coins.length,
                itemBuilder: (BuildContext context, int index) {
                  final coin = coins[index];
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
            );
          },
        ),
      ),
    );
  }
}
