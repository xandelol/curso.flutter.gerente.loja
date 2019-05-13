import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gerente_loja_app/blocs/orders_bloc.dart';
import 'package:gerente_loja_app/blocs/user_bloc.dart';
import 'package:gerente_loja_app/screens/login_screen.dart';
import 'package:gerente_loja_app/tabs/orders_tab.dart';
import 'package:gerente_loja_app/tabs/products_tab.dart';
import 'package:gerente_loja_app/tabs/users_tab.dart';
import 'package:gerente_loja_app/widgets/edit_category_dialog.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  int _page = 0;
  PageController _pageController;

  UserBloc _userBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.pinkAccent,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white54)
          )
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p){
            _pageController.jumpToPage(p);
          },
          items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person
                ),
                title: Text(
                  "Clientes",
                )
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  title: Text(
                    "Pedidos",
                  )
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  title: Text(
                    "Produtos",
                  )
              ),
          ]
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider(
            bloc: _ordersBloc,
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (p){
                setState(() {
                  _page = p;
                });
              },
              children: <Widget>[
                UsersTab(),
                OrdersTab(),
                ProductsTab(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget _buildFloating(){
    switch(_page){
      case 0:
        return null;
      case 1:
        return SpeedDial(
          child: Icon(
            Icons.sort,
          ),
          backgroundColor: Colors.pinkAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: Icon(Icons.arrow_downward, color: Colors.pinkAccent,),
              backgroundColor: Colors.white,
              label: "Concluidos Abaixo",
              labelStyle: TextStyle(fontSize: 14),
              onTap: (){
                _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
              }
            ),
            SpeedDialChild(
                child: Icon(Icons.arrow_upward, color: Colors.pinkAccent,),
                backgroundColor: Colors.white,
                label: "Concluidos Acima",
                labelStyle: TextStyle(fontSize: 14),
                onTap: (){
                  _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
                }
            ),
          ],
        );
        break;
      case 2:
        return FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.pinkAccent,
          onPressed: (){
            showDialog(context: context, builder: (context) => EditCategoryDialog());
          },
        );
        break;
    }
  }
}
