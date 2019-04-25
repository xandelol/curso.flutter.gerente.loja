import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Alexandre"),
              Text("Rua Flutter")
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "Preco Produtos",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              "Preco total",
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}
