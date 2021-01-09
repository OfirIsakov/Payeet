import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Payeet/UI_Elements/linechart.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(delegate: SliverChildListDelegate([

        BarChartSample2(),


        Row(
            children: [
              Text(
                "Transactions",
                style:
                GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6,),
                
                 
              ),
            ],
          ),
      ])),
      SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      overflow: Overflow.visible,
                      children: [
                        Positioned(
                          child: Container(

                            child: Icon(CupertinoIcons.money_dollar_circle, color: Theme.of(context).highlightColor, size: 40,),
                          ),
                          left: -60,
                        ),
                        RichText(
                            text: TextSpan(
                          style: Theme.of(context).textTheme.headline2,
                          text: "From Ofir\n",
                          children: <TextSpan>[
                            TextSpan(
                              text: "Jun 07 - 2:40 PM",
                              style: Theme.of(context).textTheme.subtitle1),
                            
                          ],
                        )),
                      ],
                    ),
                    Text(
                      r"- $10",
                      style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 20),
                    )
                  ],
                ));
          },
        ),
      ),
    ]);
  }
}
