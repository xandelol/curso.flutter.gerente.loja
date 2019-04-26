import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja_app/blocs/orders_bloc.dart';
import 'package:gerente_loja_app/blocs/user_bloc.dart';
import 'package:gerente_loja_app/screens/login_screen.dart';
import 'package:gerente_loja_app/tabs/orders_tab.dart';
import 'package:gerente_loja_app/tabs/users_tab.dart';

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
                Container(color: Colors.green,),
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
        break;
      case 2:
        break;
    }
  }
}
