import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja_app/widgets/order_header.dart';

class OrderTile extends StatelessWidget {

  final DocumentSnapshot _order;
  
  OrderTile(this._order);

  final status = [
    "", "Em preparação", "Em transporte", "Aguardando Entrega", "Entregue"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          key: Key(_order.documentID),
          initiallyExpanded: _order.data["status"] != 4,
          title: Text(
            "#${_order.documentID.substring(_order.documentID.length - 7, _order.documentID.length)} - ${status[_order.data["status"]]}",
            style: TextStyle(color: _order.data["status"] != 4 ? Colors.grey[850] : Colors.green),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(_order),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _order.data["products"].map<Widget>((p){
                      return ListTile(
                        title: Text(p["product"]["title"] + " " + p["size"]),
                        subtitle: Text(p["category"] + "/" + p["pid"]),
                        trailing: Text(
                          p["quantity"].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Firestore.instance.collection("users").document(_order["clientId"])
                              .collection("orders").document(_order.documentID).delete();
                          _order.reference.delete();
                        },
                        child: Text("Excluir"),
                        textColor: Colors.red,
                      ),
                      FlatButton(
                        onPressed: _order.data["status"] > 1 ? (){
                          _order.reference.updateData({"status":_order.data["status"]-1});
                        } : null,
                        child: Text("Regredir"),
                        textColor: Colors.grey[850],
                      ),
                      FlatButton(
                        onPressed: _order.data["status"] < 4 ? (){
                          _order.reference.updateData({"status":_order.data["status"]+1});
                        } : null,
                        child: Text("Avançar"),
                        textColor: Colors.green,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
