import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';

class TicKetCart extends StatelessWidget {
  final List<Item> itemsCart;
  TicKetCart({Key? key, required this.itemsCart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4CAF50),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Ticket"),
              SizedBox(
                width: 10,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'images/ic_receipt.svg',
                    width: 25,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                  Text(
                    itemsCart.length.toString(),
                    style: TextStyle(fontSize: 15),
                  )
                ],
              )
            ],
          ),
          actions: [
            IconButton(
                alignment: Alignment.centerLeft,
                icon: Icon(
                  Icons.person_add_outlined,
                ),
                onPressed: () {}),
            IconButton(
                alignment: Alignment.centerLeft,
                icon: Icon(
                  Icons.more_vert_outlined,
                ),
                onPressed: () {}),
          ],
        ),
        body: _home(),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(15),
          child: _buttonOrder(),
        ),
      ),
    );
  }

  var listItemCart = ['Black tea', 'Trà đào cam xả', 'Trà chanh', 'Trà vải'];

  Widget _home() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _dropDown(),
        ),
        SliverToBoxAdapter(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
            child: SizedBox(
              height: 0.5,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _itemCart(itemsCart[index]);
            },
            childCount: itemsCart.length,
          ),
        ),
        _rowTax(),
        _rowTotal(),
      ],
    );
  }

  var listItemDropDown = ["Dine in", "one", "two", "three"];

  Widget _dropDown() {
    return DropdownButton<String>(
      onChanged: (value) {
        //to do onChange
      },
      underline: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0x00000000),
        ),
      ),
      icon: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.expand_more_outlined,
        ),
      ),
      value: "Dine in",
      iconSize: 24,
      style: TextStyle(color: Colors.black),
      isExpanded: true,
      items: listItemDropDown.map((String item) {
        return DropdownMenuItem<String>(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          value: item,
        );
      }).toList(),
    );
  }

  Widget _itemCart(Item item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5, right: 5, left: 5, top: 5),
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${item.name}  x  ",
              ),
              Expanded(child: Text("1")),
              Text(
                item.price.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _rowTotal() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: 35, right: 15, left: 15),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    ((_calculator() * 10) + _calculator()).toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _rowTax() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Text("Tax"),
                  ),
                  Text(_calculator().toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buttonOrder() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 64,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff7CB342),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {},
              child: Text(
                "SAVE",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        Expanded(
            child: SizedBox(
          height: 64,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff7CB342),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "CHARGE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  ((_calculator() * 10) + _calculator()).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        )),
      ],
    );
  }

  int _calculator() {
    var tax = 0;
    itemsCart.forEach((item) {
      tax += (item.price ~/ 10).toInt();
    });
    return tax;
  }
}
