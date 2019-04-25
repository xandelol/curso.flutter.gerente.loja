import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja_app/blocs/orders_bloc.dart';
import 'package:gerente_loja_app/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _ordersbloc = BlocProvider.of<OrdersBloc>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: StreamBuilder<List>(
        stream: _ordersbloc.outOrders,
        builder: (context, snapshot) {

          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
              ),
            );
          } else if(snapshot.data.length == 0){
            return Center(
              child: Text(
                "Nenhum pedido encontrado!",
                style: TextStyle(color: Colors.pinkAccent),
              ),
            );
          }else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return OrderTile(snapshot.data[index]);
                }
            );
          }
        }
      ),
    );
  }
}
