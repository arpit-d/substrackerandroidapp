import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:jiffy/jiffy.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/models/subsdatalist.dart';
import 'package:substracker/notifications/notification_manager.dart';
import 'package:substracker/suggestions/name_data.dart';

enum PaymentStatus { paid, pending }
enum Notification { oneDay, sameDay }

class NewSubForm extends StatefulWidget {
  @override
  _NewSubFormState createState() => _NewSubFormState();
}

class _NewSubFormState extends State<NewSubForm> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // controller
  final TextEditingController _typeAheadController = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController notiCtl = TextEditingController();

  // var declaration
  final Color cursorColor = const Color(0xFFEA5455);
  String name;
  double price;
  DateTime payDate;
  String periodNo = '1';
  String periodType = 'Month';
  PaymentStatus _c = PaymentStatus.paid;
  Notification _n;
  String payStatus = 'Paid';
  String noti = "One";
  String category, notes, payMethod;

  FocusNode myFocusNode,
      myFocusNode1,
      myFocusNode2,
      myFocusNode3,
      myFocusNode4,
      myFocusNode5;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    myFocusNode1 = FocusNode();
    myFocusNode2 = FocusNode();
    myFocusNode3 = FocusNode();
    myFocusNode4 = FocusNode();
    myFocusNode5 = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode1.dispose();
    myFocusNode.dispose();
    myFocusNode2.dispose();
    myFocusNode3.dispose();
    myFocusNode4.dispose();
    myFocusNode5.dispose();
    super.dispose();
  }

  // keys
  NotificationManager _manager = NotificationManager();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final subsDataList = Provider.of<SubsDataList>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: GradientText(
          'New Subscription',
          gradient: LinearGradient(colors: [
            Color(0xFFFEB692),
            Color(0xFFEA5455),
          ]),
          style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Allura',
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    cursorColor: cursorColor,
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(myFocusNode),
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'Price',
                        hintText: '0.00',
                        prefixIcon: const Icon(LineAwesomeIcons.money)),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(9),
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      price = double.parse(v);
                    },
                    validator: (val) => val.isEmpty ? 'Enter price!' : null,
                  ),
                  buildSizedBox(context),
                  TypeAheadFormField(
                    hideOnEmpty: true,
                    keepSuggestionsOnLoading: false,
                    getImmediateSuggestions: false,
                    textFieldConfiguration: TextFieldConfiguration(
                      cursorColor: cursorColor,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(36),
                      ],
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) {
                        name = value;
                      },
                      focusNode: myFocusNode,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'E.g. Spotify',
                          prefixIcon: const Icon(
                            LineAwesomeIcons.clipboard,
                          )),
                      controller: this._typeAheadController,
                    ),
                    suggestionsCallback: (pattern) {
                      return NamesService.getSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF2d2d2d),
                          ),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(2)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              suggestion,
                              style: TextStyle(
                                  color: const Color(0xFFEA5455), fontSize: 17),
                            ),
                          ],
                        ),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController.text = suggestion;
                      name = suggestion;
                    },
                    validator: (val) => val.isEmpty ? 'Enter name!' : null,
                    onSaved: (suggestion) {
                      setState(() {
                        name = suggestion;
                      });
                    },
                  ),
                  buildSizedBox(context),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter date!' : null,
                    controller: dateCtl,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(LineAwesomeIcons.calendar),
                      labelText: 'Payment Date',
                      suffixIcon: IconButton(
                        icon: const Icon(
                          LineAwesomeIcons.trash_o,
                        ),
                        onPressed: () {
                          dateCtl.clear();
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.56,
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  child: child,
                                ),
                              ),
                            ],
                          );
                        },
                      ).then(
                        (v) {
                          FocusScope.of(context).requestFocus(myFocusNode1);
                          payDate = v;
                          dateCtl.text =
                              '${payDate.day} - ${payDate.month} - ${payDate.year}';
                        },
                      );
                    },
                  ),
                  buildSizedBox(context),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          cursorColor: cursorColor,
                          onChanged: (v) {
                            periodNo = v;
                          },
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (String v) {
                            FocusScope.of(context).requestFocus(myFocusNode2);
                          },
                          focusNode: myFocusNode1,
                          validator: (val) =>
                              (int.parse(val) == 0 || int.parse(val) == null)
                                  ? 'Value cannot be 0!'
                                  : null,
                          decoration: InputDecoration(
                              labelText: 'Every', hintText: '1'),
                          initialValue: '1',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField(
                          // isExpanded: true,
                          icon: const Icon(
                            LineAwesomeIcons.angle_double_down,
                          ),
                          decoration:
                              const InputDecoration(labelText: 'Time Period'),
                          value: 'Month',
                          items: const <String>['Day', 'Week', 'Month', 'Year']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (v) {
                            FocusScope.of(context).requestFocus(myFocusNode2);
                            periodType.contains('.')
                                ? periodType = null
                                : periodType = v;
                            // print(periodType);
                          },
                        ),
                      ),
                    ],
                  ),
                  buildSizedBox(context),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(myFocusNode3);
                    },
                    cursorColor: cursorColor,
                    focusNode: myFocusNode2,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Notes(optional)',
                      hintText: 'e.g Bought during sale',
                      prefixIcon: const Icon(
                        LineAwesomeIcons.comment,
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    onChanged: (v) {
                      notes = v;
                    },
                  ),
                  buildSizedBox(context),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(myFocusNode4);
                    },
                    cursorColor: cursorColor,
                    focusNode: myFocusNode3,
                    decoration: const InputDecoration(
                      labelText: 'Category(optional)',
                      hintText: 'e.g Entertainment',
                      prefixIcon: Icon(
                        LineAwesomeIcons.tag,
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    onChanged: (v) {
                      category = v;
                    },
                  ),
                  buildSizedBox(context),
                  TextFormField(
                    cursorColor: cursorColor,
                    textCapitalization: TextCapitalization.words,
                    focusNode: myFocusNode4,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        LineAwesomeIcons.credit_card,
                      ),
                      labelText: 'Payment Method-optional',
                      hintText: 'E.g Credit Card',
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    keyboardType: TextInputType.text,
                    onChanged: (v) {
                      payMethod = v;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  TextFormField(
                    controller: notiCtl,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(LineAwesomeIcons.bell),
                      labelText: 'Notification Alert',
                    ),
                    readOnly: true,
                    onTap: () {
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Create Notification Alert'),
                            content: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: const Text('One Day Before'),
                                    leading: Radio(
                                      activeColor: const Color(0xFFEA5455),
                                      value: Notification.oneDay,
                                      groupValue: _n,
                                      onChanged: (Notification value) {
                                        setState(() {
                                          noti = 'One';
                                          _n = value;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('Same Day'),
                                    leading: Radio(
                                      activeColor: const Color(0xFFEA5455),
                                      value: Notification.sameDay,
                                      groupValue: _n,
                                      onChanged: (Notification value) {
                                        setState(() {
                                          noti = 'Same';
                                          _n = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Set Reminder'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      ).then((value) {
                        if (noti == "One") {
                          notiCtl.text = "One Day Before";
                        } else {
                          notiCtl.text = "Same Day";
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  const Text(
                    'PAYMENT STATUS',
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('Paid'),
                          leading: Radio(
                            activeColor: const Color(0xFFEA5455),
                            value: PaymentStatus.paid,
                            groupValue: _c,
                            onChanged: (PaymentStatus value) {
                              setState(() {
                                payStatus = 'Paid';
                                _c = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Pending'),
                          leading: Radio(
                            activeColor: const Color(0xFFEA5455),
                            value: PaymentStatus.pending,
                            groupValue: _c,
                            onChanged: (PaymentStatus value) {
                              setState(() {
                                payStatus = 'Pending';
                                _c = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildSizedBox(context),
                  InkWell(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          const Color(0xFFFEB692),
                          const Color(0xFFEA5455)
                        ]),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: const Text(
                          'SAVE SUBSCRIPTION',
                          style: const TextStyle(
                              color: const Color(0xFFF1f1f1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        final db =
                            Provider.of<MyDatabase>(context, listen: false);
                        final sub = Sub(
                            id: null,
                            subsPrice: price,
                            subsName: name,
                            notes: notes,
                            payStatus: payStatus,
                            payMethod: payMethod,
                            payDate: payDate,
                            periodNo: periodNo,
                            periodType: periodType,
                            category: category,
                            currency: '\$',
                            archive: 'false');
                        db.insertSub(sub);

                        if (noti == "One") {
                          DateTime realDays;
                          print(payDate.toIso8601String());
                          DateTime d = payDate;
                          print(d.toIso8601String());
                          if (periodType == 'Day') {
                            realDays = Jiffy(d).add(
                                days: int.parse(periodNo),
                                hours: 21,
                                minutes: 00);
                          } else if (periodType == 'Week') {
                            realDays = Jiffy(d).add(
                                weeks: int.parse(periodNo),
                                hours: 21,
                                minutes: 0);
                          } else if (periodType == 'Year') {
                            realDays = Jiffy(d).add(
                                years: int.parse(periodNo),
                                hours: 21,
                                minutes: 0);
                          } else {
                            realDays = Jiffy(d).add(
                                months: int.parse(periodNo),
                                hours: 21,
                                minutes: 0);
                          }

                          _manager.noti(realDays.subtract(Duration(days: 1)),
                              name, "Tomorrow", price.toString());
                        } else {
                          DateTime realDays;

                          DateTime d = payDate;

                          if (periodType == 'Day') {
                            realDays = Jiffy(d).add(
                                days: int.parse(periodNo),
                                hours: 7,
                                minutes: 0);
                          } else if (periodType == 'Week') {
                            realDays = Jiffy(d).add(
                                weeks: int.parse(periodNo),
                                hours: 7,
                                minutes: 0);
                          } else if (periodType == 'Year') {
                            realDays = Jiffy(d).add(
                                years: int.parse(periodNo),
                                hours: 7,
                                minutes: 0);
                          } else {
                            realDays = Jiffy(d).add(
                                months: int.parse(periodNo),
                                hours: 7,
                                minutes: 0);
                          }

                          _manager.noti(realDays, name, "Today", price.toString());
                        }

                        Navigator.of(context).pop();

                        Flushbar(
                          message: "Subscription Added Succesfully",
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          flushbarStyle: FlushbarStyle.FLOATING,
                          reverseAnimationCurve: Curves.decelerate,
                          forwardAnimationCurve: Curves.ease,
                          margin: EdgeInsets.all(8),
                          borderRadius: 8,
                          isDismissible: true,
                          duration: Duration(seconds: 3),
                          icon: const Icon(
                            LineAwesomeIcons.check_circle,
                            color: const Color(0xFFEA5455),
                          ),
                        )..show(context);
                      }
                    },
                  ),
                  buildSizedBox(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.014);
}
