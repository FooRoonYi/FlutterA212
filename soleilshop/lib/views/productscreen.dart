import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  //final Admin admin;
  //const ProductScreen({Key? key, required this.admin}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Product'),
        ),
        drawer: Drawer(
          child: ListView(children: [
            const UserAccountsDrawerHeader(
                accountName: Text('Foo Roon Yi'),
                accountEmail: Text('janiceyi02@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/736x/aa/42/7a/aa427a67d5dc8bc31629fbe50cc62abd.jpg"),
                )),
            /*_createDrawerItem(
                icon: Icons.production_quantity_limits,
                text: 'My Dashboard',
                onTap: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: ((context) => MainScreen(admin: widget.admin)));
                }),*/
            _createDrawerItem(
                icon: Icons.production_quantity_limits,
                text: 'Products',
                onTap: () {}),
            _createDrawerItem(
                icon: Icons.shopping_cart, text: 'Cart', onTap: () {}),
            _createDrawerItem(
                icon: Icons.account_circle_rounded,
                text: 'Profile',
                onTap: () {}),
          ]),
        ),
        body: const Center(
          child: Text('Hello World'),
        ));
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  /* _loadProducts(){
    if(widget.user.email == "na"){
      setState(() {
        titlecenter = "Unregistered user";
      });
      return;
    }
    http.post(Uri.parse(Config.server + "/"))
  }

  void _initState() {
    super.initState();
    _loadProducts();
  }*/
}
