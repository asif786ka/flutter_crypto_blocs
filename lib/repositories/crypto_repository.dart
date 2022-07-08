import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/coin_model.dart';
import '../models/failure_model.dart';

class CryptoRepository {
  static const String _baseUrl = 'https://min-api.cryptocompare.com/';
  static const int perPage = 20;

  final http.Client _httpClient;

  CryptoRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Coin>> getTopCoins() async {
    const requestUrl =
        '${_baseUrl}data/top/totalvolfull?limit=$perPage&tsym=USD';
    try {
      final response = await _httpClient.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final coinList = List.from(data['Data']);
        return coinList.map((e) => Coin.fromMap(e)).toList();
      }
      return [];
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw Failure(message: err.toString());
    }
  }
}