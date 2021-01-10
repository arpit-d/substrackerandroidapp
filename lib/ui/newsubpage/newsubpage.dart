import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/functions/getNotiTime.dart';
import 'package:substracker/suggestions/name_data.dart';
import 'package:intl/intl.dart';

enum PaymentStatus { paid, pending }
enum Notification { none, oneDay, sameDay }

class NewSubForm extends StatefulWidget {
  bool editForm;
  DateTime createdAt;
  int initialId;
  String initialPrice;
  String initialName;
  DateTime initialDate;
  String initialPeriodNo;
  String initialPeriodType;
  String initialNotes;
  String initialCategory;
  String initialPaymentMethod;
  String initialStatus;

  NewSubForm(this.editForm,
      [this.initialId,
      this.initialPrice,
      this.initialName,
      this.initialDate,
      this.initialPeriodNo,
      this.initialPeriodType,
      this.initialNotes,
      this.initialCategory,
      this.initialPaymentMethod,
      this.initialStatus,
      this.createdAt]);
  @override
  _NewSubFormState createState() => _NewSubFormState();
}

class _NewSubFormState extends State<NewSubForm> {
  // controllers

  TextEditingController notiCtl = TextEditingController();

  // var declaration
  final Color cursorColor = const Color(0xFFEA5455);
  String name;
  double price;
  DateTime payDate;
  String periodNo = '1';
  String periodType = 'Month';
  PaymentStatus _c = PaymentStatus.paid;
  Notification _n = Notification.none;
  String payStatus = 'Paid';
  String noti;
  String category, notes, payMethod;
  DateTime createdAt;
  TimeOfDay notificationTime = TimeOfDay(hour: 21, minute: 00);
  TextEditingController _typeAheadController = TextEditingController();
  TextEditingController dateCtl = TextEditingController();

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
    myFocusNode.dispose();
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    myFocusNode3.dispose();
    myFocusNode4.dispose();
    myFocusNode5.dispose();
    super.dispose();
  }

  // keys
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('subs');
    String format = box.get('dateFormat', defaultValue: 'dd/MM/yy');
    TextEditingController editDateCtl = TextEditingController(
        text: widget.editForm
            ? DateFormat(format).format(widget.initialDate)
            : null);
    final db = Provider.of<MyDatabase>(context, listen: false);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: GradientText(
          widget.editForm ? 'Edit Subscription' : 'New Subscription',
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
                    initialValue: widget.editForm ? widget.initialPrice : null,
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
                  widget.editForm
                      ? TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(36),
                          ],
                          textCapitalization: TextCapitalization.words,
                          initialValue:
                              widget.editForm ? widget.initialName : null,
                          cursorColor: cursorColor,
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).requestFocus(myFocusNode),
                          textInputAction: TextInputAction.next,
                          focusNode: myFocusNode,
                          decoration: const InputDecoration(
                              labelText: 'Name',
                              hintText: 'E.g. Spotify',
                              prefixIcon: const Icon(
                                LineAwesomeIcons.clipboard,
                              )),
                          keyboardType: TextInputType.name,
                          onChanged: (v) {
                            name = (v);
                            print(name);
                          },
                          validator: (val) =>
                              val.isEmpty ? 'Enter price!' : null,
                        )
                      : TypeAheadFormField(
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
                              // widget.initialName = value;
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
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF2d2d2d),
                                ),
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(2)),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  Text(
                                    suggestion,
                                    style: TextStyle(
                                        color: const Color(0xFFEA5455),
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {
                            this._typeAheadController.text = suggestion;
                            name = suggestion;
                          },
                          validator: (val) =>
                              val.isEmpty ? 'Enter name!' : null,
                          onSaved: (suggestion) {
                            setState(() {
                              name = suggestion;
                            });
                          },
                        ),
                  buildSizedBox(context),
                  widget.editForm
                      ? TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter date!' : null,
                          controller: editDateCtl,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(LineAwesomeIcons.calendar),
                            labelText: 'Payment Date',
                            suffixIcon: IconButton(
                              icon: const Icon(
                                LineAwesomeIcons.trash_o,
                              ),
                              onPressed: () {
                                editDateCtl.clear();
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
                                            MediaQuery.of(context).size.height *
                                                0.56,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.87,
                                        child: child,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).then(
                              (v) {
                                FocusScope.of(context)
                                    .requestFocus(myFocusNode1);
                                payDate = v;
                                widget.initialDate = (payDate);
                                editDateCtl.text =
                                    DateFormat(format).format(payDate);
                              },
                            );
                          },
                        )
                      : TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter date!' : null,
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
                                            MediaQuery.of(context).size.height *
                                                0.56,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.87,
                                        child: child,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).then(
                              (v) {
                                FocusScope.of(context)
                                    .requestFocus(myFocusNode1);
                                payDate = v;
                                dateCtl.text =
                                    DateFormat(format).format(payDate);
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
                            setState(() {
                              periodNo = v;
                              widget.initialPeriodNo = v;
                            });
                            periodNo = v;
                            print(periodNo);
                          },
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (String v) {
                            FocusScope.of(context).requestFocus(myFocusNode2);
                          },
                          focusNode: myFocusNode1,
                          validator: (val) => (int.parse(val) == 0 ||
                                  int.parse(val) == null ||
                                  val.isEmpty)
                              ? 'Value cannot be 0 or empty!'
                              : null,
                          decoration: InputDecoration(
                              labelText: 'Every', hintText: '1'),
                          initialValue: widget.editForm
                              ? widget.initialPeriodNo
                              : periodNo,
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
                          value: widget.editForm
                              ? widget.initialPeriodType
                              : periodType,
                          items: const <String>['Day', 'Week', 'Month', 'Year']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (v) {
                            FocusScope.of(context).requestFocus(myFocusNode2);
                            setState(() {
                              periodType.contains('.')
                                  ? periodType = null
                                  : periodType = v;
                              print(periodType);
                              widget.initialPeriodType = v;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  buildSizedBox(context),
                  TextFormField(
                    initialValue: widget.editForm ? widget.initialNotes : null,
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
                    initialValue:
                        widget.editForm ? widget.initialCategory : null,
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
                    initialValue:
                        widget.editForm ? widget.initialPaymentMethod : null,
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
                  !widget.editForm
                      ? TextFormField(
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
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: const Text('No Alerts'),
                                          leading: Radio(
                                            activeColor:
                                                const Color(0xFFEA5455),
                                            value: Notification.none,
                                            groupValue: _n,
                                            onChanged: (Notification value) {
                                              setState(() {
                                                noti = 'No';
                                                _n = value;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text('One Day Before'),
                                          leading: Radio(
                                            activeColor:
                                                const Color(0xFFEA5455),
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
                                            activeColor:
                                                const Color(0xFFEA5455),
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
                                        ListTile(
                                          title: Text(notificationTime.minute <
                                                      10 ||
                                                  notificationTime.minute ==
                                                      null
                                              ? 'Time: ${notificationTime.hour}:0${notificationTime.minute}'
                                              : 'Time: ${notificationTime.hour}:${notificationTime.minute}'),
                                          trailing:
                                              Icon(LineAwesomeIcons.clock_o),
                                          onTap: () {
                                            return showTimePicker(
                                              initialTime: TimeOfDay(
                                                  hour: 21, minute: 00),
                                              context: context,
                                            ).then(
                                              (selectedTime) async {
                                                setState(() {
                                                  var t = TimeOfDay(
                                                      hour: 21, minute: 00);
                                                  if (selectedTime == null) {
                                                    notificationTime = t;
                                                  } else {
                                                    notificationTime =
                                                        selectedTime;
                                                  }
                                                });
                                              },
                                            );
                                          },
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
                              } else if (noti == "Same") {
                                notiCtl.text = "Same Day";
                              } else {
                                notiCtl.text = 'No Alerts';
                              }
                            });
                          },
                        )
                      : Container(),
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
                        createdAt = DateTime.now();
                        if (widget.editForm) {
                          final sub = Sub(
                              id: widget.initialId,
                              subsPrice:
                                  price ?? double.parse(widget.initialPrice),
                              subsName: name ?? widget.initialName,
                              notes: notes ?? widget.initialNotes,
                              payStatus: payStatus ?? widget.initialStatus,
                              payMethod:
                                  payMethod ?? widget.initialPaymentMethod,
                              payDate: payDate ?? widget.initialDate,
                              periodNo: periodNo == '1'
                                  ? widget.initialPeriodNo
                                  : periodNo,
                              periodType: periodType == 'Month'
                                  ? widget.initialPeriodType
                                  : periodType,
                              category: category ?? widget.initialCategory,
                              currency: '\$',
                              archive: 'false',
                              createdAt: widget.createdAt);
                          db.updateSub(sub);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } else {
                          print(periodNo);
                          print(periodType);
                          Sub sub = Sub(
                            id: null,
                            subsPrice: price,
                            subsName: name,
                            notes: notes,
                            payStatus: payStatus,
                            payMethod: payMethod,
                            payDate: payDate,
                            periodNo: periodNo ?? '1',
                            periodType: periodType ?? 'Month',
                            category: category,
                            currency: '\$',
                            archive: 'false',
                            createdAt: createdAt,
                          );
                          db.insertSub(sub);

                          Navigator.of(context).pop('Success');

                          setNotification(
                              periodType ?? 'Month',
                              payDate,
                              periodNo ?? '1',
                              name,
                              price,
                              noti,
                              notificationTime,
                              createdAt);
                        }
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
