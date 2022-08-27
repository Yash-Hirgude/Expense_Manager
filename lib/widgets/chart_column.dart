import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class chartCol extends StatelessWidget {
  late String DayInitial;
  late double fract;
  late double spending;
  chartCol(this.DayInitial, this.fract, this.spending);
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,Constraints){
      return Column(
      children: [
        Container(
          height: Constraints.maxHeight *0.1,
          child: FittedBox(
            child: Text('\₹${spending.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: Constraints.maxHeight * 0.05,),
        Container(
          height: Constraints.maxHeight * 0.7,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: fract,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Constraints.maxHeight * 0.05,
        ),
        Container(height: Constraints.maxHeight * 0.1,child: FittedBox(child: Text(DayInitial))),
      ],
    );
    });
  }
}
