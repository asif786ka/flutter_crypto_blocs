import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/crypto/crypto_bloc.dart';
import '../models/coin_model.dart';
import '../repositories/crypto_repository.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Top Coins')),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Colors.grey[900]!,
            ],
          ),
        ),
        child: BlocBuilder<CryptoBloc, CryptoState>(
          builder: (context, state) {
            switch (state.status) {
              case CryptoStatus.loaded:
                return ListView.builder(
                  itemCount: state.coins.length,
                  itemBuilder: (BuildContext context, int index) {
                    final coin = state.coins[index];
                    return ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${++index}',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        coin.fullName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        coin.name,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Text(
                        '\$${coin.price.toStringAsFixed(4)}',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                );
              case CryptoStatus.error:
                return Center(
                  child: Text(
                    state.failure.message,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}