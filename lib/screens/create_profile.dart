import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:workoutapp/helper/navigation_helper.dart';
import 'package:workoutapp/style/styles.dart';

import 'home.dart';

class CreateProfileState extends State<CreateProfile> {
  CreateProfileSteps currentStep = CreateProfileSteps.name;

  String inputValue = "";
  String hintText = "Enter your name";
  String topMessage = "How should I call you?";
  String buttonText = "Next";
  String weightUnitsToUse = "kg";

  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: getPageItems()),
    ));
  }

  nextProfileStep() {
    switch (this.currentStep) {
      case CreateProfileSteps.name:
        this.currentStep = CreateProfileSteps.gender;
        this.topMessage = "What's your gender?";
        break;
      case CreateProfileSteps.gender:
        this.currentStep = CreateProfileSteps.age;
        this.topMessage = "How old are you?";
        this.hintText = "Enter your age";
        break;
      case CreateProfileSteps.age:
        this.currentStep = CreateProfileSteps.weight;
        this.topMessage = "How much do you weigh?";
        this.hintText = "Enter your weight";
        break;
      case CreateProfileSteps.weight:
        this.currentStep = CreateProfileSteps.finished;
        this.topMessage = "You're all set up :)";
        this.buttonText = "Get Started";
        break;
      default:
    }
    _controller.clear();
  }

  List<Widget> getPageItems() {
    var result = new List<Widget>();
    result.add(topMessageContainer());
    if (this.currentStep != CreateProfileSteps.finished) {
      if (this.currentStep == CreateProfileSteps.gender) {
        result.add(genderInputContainer());
      } else if (this.currentStep == CreateProfileSteps.weight) {
        result.add(inputWithUnitSelector());
      } else {
        result.add(inputContainer());
      }
    }
    if (this.currentStep != CreateProfileSteps.gender) {
      result.add(bottomButtonContainer());
    }
    return result;
  }

  Container topMessageContainer() {
    return Container(
      child: Text(
        this.topMessage,
        style: Styles.titleDarkLarge(),
        textAlign: TextAlign.start,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
    );
  }

  Container inputContainer() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: TextField(
          keyboardType: this.currentStep == CreateProfileSteps.age ||
                  this.currentStep == CreateProfileSteps.weight
              ? TextInputType.number
              : TextInputType.text,
          controller: _controller,
          decoration: InputDecoration(
            hintText: this.hintText,
          ),
          textAlign: TextAlign.center,
          onChanged: (String str) {
            setState(() {
              inputValue = str;
            });
          },
        ));
  }

  Container genderInputContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[buttonWidget(" Male "), buttonWidget("Female")],
      ),
    );
  }

  Container inputWithUnitSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: this.hintText,
            ),
            textAlign: TextAlign.center,
            onChanged: (String str) {
              setState(() {
                inputValue = str;
              });
            },
          ),),
          DropdownButtonHideUnderline(child: new DropdownButton(
            value: this.weightUnitsToUse,
            onChanged: (String newValue) {
              setState(() {
                this.weightUnitsToUse = newValue;
              });
            },
            items: <String>['kg', 'lbs']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
          )
        ],
      ),
    );
  }

  Container bottomButtonContainer() {
    return Container(child: buttonWidget(this.buttonText));
  }

  FlatButton buttonWidget(String text) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        setState(() {
          if (this.currentStep == CreateProfileSteps.finished) {
            Navigator.pushNamed(
              context,
              Pages.home,
            );
          } else {
            nextProfileStep();
          }
        });
      },
      splashColor: Theme.of(context).accentColor,
      child: Text(text,
          style: Styles.buttonTextLight()
      )
    );
  }
}

class CreateProfile extends StatefulWidget {
  @override
  CreateProfileState createState() => new CreateProfileState();
}

enum CreateProfileSteps { name, gender, age, weight, finished }
