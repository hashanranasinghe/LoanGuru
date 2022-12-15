import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:intl/intl.dart';
import '../models/loans.dart';

class BankApi {
  static Future<List<Bank>> ReadJsonData(text) async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/json/data.json');
    final list = json.decode(jsonData) as List<dynamic>;

    final hList = list.map((e) => Bank.fromJson(e)).toList();
    var seen = Set<String>();
    final l = hList
        .toList()
        .where((element) => seen.add(element.loanCategory as String))
        .toList()
        .where((element) => element.bank == text)
        .toList();
    return l;
  }

  static Future<List<String>> ReadBankNames() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/json/data.json');
    final list = json.decode(jsonData) as List<dynamic>;

    final hList = list.map((e) => Bank.fromJson(e)).toList();
    var seen = Set<String>();
    final l = hList
        .toList()
        .where((element) => seen.add(element.bank as String))
        .toList();
    return seen.toList();
  }

  static Future<List<Bank>> ReadData(text) async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/json/data.json');
    final list = json.decode(jsonData) as List<dynamic>;

    final hList = list.map((e) => Bank.fromJson(e)).toList();
    final l = hList
        .toList()
        .where((element) => element.loanCategory == text)
        .toList();
    return l;
  }

  static Future<List<Bank>> ReadDetails(text) async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/json/data.json');
    final list = json.decode(jsonData) as List<dynamic>;

    final hList = list.map((e) => Bank.fromJson(e)).toList();
    final l =
        hList.toList().where((element) => element.loanName == text).toList();
    return l;
  }

  static Future<List<Bank>> ReadFilterData(
      bank, loanCategory, period, job, interest) async {
    print("===================================");
    print(bank);
    print(loanCategory);
    print(period);
    print(interest);
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/json/data.json');
    final list = json.decode(jsonData) as List<dynamic>;

    final hList = list.map((e) => Bank.fromJson(e)).toList();
    final l = hList
        .toList()
        .where((element) => ((interest != null &&
                element.interestRate
                    .toString()
                    .contains(interest.toString())) &&
            (loanCategory != null &&
                element.loanCategory
                    .toString()
                    .contains(loanCategory.toString())) &&
            (element.period != null &&

                element.period!.replaceAll(new RegExp(r'[^0-9]'), '').contains(period))
    )

    )
        .toList();

    return l;
  }
}
