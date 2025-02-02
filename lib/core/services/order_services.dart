import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orders_project/core/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:orders_project/utils/constants.dart';

import 'firebase_services.dart';

class OrderService with ChangeNotifier {
  // static final List<Order> _newOrders = [];

  final String _token;
  final String _userId;
  final List<Order> _items = [];
  List<Order> get items => [..._items];
  int get itemsCount => _items.length;

  OrderService(
    this._token,
    this._userId,
    this._items,
  );

  // Get Orders from Firebase to _items;
  Future<void> fetchOrdersData() async {
    _items.clear();

    final response = await http
        .get(Uri.parse('${Constants.URL_ORDER}/$_userId.json?auth=$_token'));

    if (response.body == 'null') return;

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      data.forEach((orderId, orderData) {
        Order _order = Order(
          id: orderData['id'],
          problem: orderData['problem'],
          clientID: orderData['clientID'],
          technicalID: orderData['technicalID'],
        );
        _items.add(_order);
      });
    } else {
      throw Exception('Falha em carregar as ordens finalizadas.');
    }
    notifyListeners();
  }

  Future<void> updateData(Order order) async {
    int index = _items.indexWhere((p) => p.id == order.id);
    await FirebaseServices().updateDataInFirebase(
      index: index,
      dataId: order.id,
      items: _items,
      url: Constants.URL_ORDER,
      jsonData: order.toJson(),
    );

    _items[index] = order;
    notifyListeners();
  }

  Future<void> saveData(Map<String, dynamic> formData) async {
    // When adding something new via formData, it has no id.
    // So, if it doesn't have an id, it's something new, but if it does, it's something old.
    bool hasId = formData['id'] != null;

    Order newOrder = Order(
      id: hasId ? formData['id'] : UniqueKey().toString(),
      problem: formData['problem'] as String,
      clientID: formData['clientID'] as String,
      technicalID: formData['technicalID'] as String,
    );

    if (hasId) {
      updateData(newOrder);
    } else {
      addData(newOrder);
    }
  }

  Future<void> addData(Order order) async {
    Map<String, dynamic> orderJson = order.toJson();
    FirebaseServices().addDataInFirebase(
        orderJson, '${Constants.URL_ORDER}/${order.technicalID}', _token);

    Order jsonData = Order(
        id: order.id,
        problem: order.problem,
        clientID: order.clientID,
        technicalID: order.technicalID);
    _items.add(jsonData);
    notifyListeners();
  }
}
