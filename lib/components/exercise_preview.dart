
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/models/rep_model.dart';

class ExercisePreview {
  Container single(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
      children: <Widget>[
        headerRow(context),
        descriptionRow(RepModel.testList(), context),

        headerRow(context),
        descriptionRow(RepModel.testList(), context),

        headerRow(context),
        descriptionRow(RepModel.testList(), context),

        headerRow(context),
        descriptionRow(RepModel.testList(), context),

        headerRow(context),
        descriptionRow(RepModel.testList(), context),

      ],
      )
    );
  }

   headerRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("Bench Press",
        style: Theme.of(context).textTheme.body1,)
      ],
    );
  }

  Row descriptionRow(List<RepModel> items, BuildContext context) {
    List<Container> itemContainers = items.map((item) => Container(
      margin: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 20.0),
      padding: EdgeInsets.all(2),
      child: Text(
        "${item.repCount}x${item.weight}",
        style: Theme.of(context).textTheme.display3,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).accentColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(25))
      ),
    )).toList();

    List<Widget> children = new List();
    itemContainers.forEach((item) => children.add(item));

    return Row(
      children: children
    );
  }
}