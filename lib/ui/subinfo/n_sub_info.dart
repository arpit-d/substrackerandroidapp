import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/functions/getDate.dart';
import 'package:substracker/functions/getNotiTime.dart';

import 'package:intl/intl.dart';
import 'package:substracker/ui/newsubpage/newsubpage.dart';
import 'package:substracker/ui/subinfo/sub_info_widget.dart';

import 'package:substracker/widgets/titleText.dart';

enum PaymentStatus { paid, pending }

// ignore: must_be_immutable
class NewSubInfo extends StatefulWidget {
  DateTime createdAt;
  String name, periodType;
  double charges;
  String periodNo;
  String payStatus;
  DateTime payDate;
  DateTime firstPayment;
  String notes;
  String category;
  String payMethod;
  int id;
  double initialCharges;
  NewSubInfo(
      {this.createdAt,
      this.name,
      this.charges,
      this.periodType,
      this.periodNo,
      this.payStatus,
      this.firstPayment,
      this.notes,
      this.payDate,
      this.category,
      this.payMethod,
      this.id,
      this.initialCharges});

  @override
  _NewSubInfoState createState() => _NewSubInfoState();
}

class _NewSubInfoState extends State<NewSubInfo> {
  PaymentStatus _paymentStatus;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context, listen: false);
    final box = Hive.box('subs');
    String format = box.get('dateFormat', defaultValue: 'dd/MM/yy');
    if (widget.payStatus == 'Paid') {
      _paymentStatus = PaymentStatus.paid;
    } else {
      _paymentStatus = PaymentStatus.pending;
    }
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.arrow_left),
          tooltip: 'Go Back',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const TitleText('Subscription Info'),
        centerTitle: true,
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(LineAwesomeIcons.pencil),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => NewSubForm(
                            true,
                            widget.id,
                            widget.charges.toString(),
                            widget.name,
                            (widget.firstPayment),
                            widget.periodNo,
                            widget.periodType,
                            widget.notes,
                            widget.category,
                            widget.payMethod,
                            widget.payStatus,
                            widget.createdAt,

                            // createdAt: item.createdAt,
                            // name: item.subsName,
                            // firstPayment: item.payDate,
                            // charges: item.subsPrice,
                            // periodNo: item.periodNo,
                            // notes: item.notes,
                            // periodType: item.periodType,
                            // payStatus: item.payStatus,
                            // payDate: item.payDate,
                            // payMethod: item.payMethod,
                            // category: item.category,
                            // id: item.id,
                            // initialCharges: (item.subsPrice),
                          )));
            },
          ),
          IconButton(
              icon: const Icon(LineAwesomeIcons.trash),
              tooltip: 'Delete',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete subscription record?"),
                      content: const Text(
                          "Are you sure you want to delete this record? Action can't be reversed!"),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text("YES"),
                          onPressed: () {
                            final sub = Sub(
                                id: widget.id,
                                subsPrice: widget.charges,
                                subsName: widget.name,
                                notes: widget.notes,
                                payStatus: widget.payStatus,
                                payMethod: widget.payMethod,
                                payDate: widget.payDate,
                                periodNo: widget.periodNo,
                                periodType: widget.periodType,
                                category: widget.category,
                                currency: '\$',
                                archive: 'false',
                                createdAt: widget.createdAt);

                            removeNotifications(widget.createdAt);
                            db.deleteTask(sub);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: const Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  },
                );
              })
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.89,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      initialValue: '${widget.charges}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 47,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: w * 0.2,
                      child: Divider(
                        height: h * 0.01,
                        thickness: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  const Center(
                    child: const Text(
                      'USD',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: w * 0.2,
                      child: Divider(
                        height: h * 0.03,
                        thickness: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  SubInfoWidget(
                    name: '${widget.name}',
                    label: 'Name',
                  ),
                  CustomDivider(),
                  SubInfoWidget(
                    name: getRealDate(widget.payDate, widget.periodNo,
                            widget.periodType, true, format)
                        .toString(),
                    label: 'Next Payment',
                  ),
                  CustomDivider(),
                  SubInfoWidget(
                    name: 'Every ' + widget.periodNo + ' ' + widget.periodType,
                    label: 'Billing period',
                  ),
                  CustomDivider(),
                  SubInfoWidget(
                    name: DateFormat(format).format(widget.firstPayment),
                    label: 'First payment',
                  ),
                  CustomDivider(),
                  SubInfoWidget(
                    name: widget.notes == null ? '  ' : widget.notes,
                    label: 'Note',
                  ),
                  CustomDivider(),
                  SubInfoWidget(
                    name: widget.category == null ? '  ' : widget.category,
                    label: 'Category',
                  ),
                  CustomDivider(),
                  SubInfoWidget(
                    name: widget.payMethod == null ? '  ' : widget.payMethod,
                    label: 'Payment method',
                  ),
                  CustomDivider(),
                  SubInfoWidget(
                    name: widget.payStatus == null ? '  ' : widget.payStatus,
                    label: 'Payment status',
                  ),
                  CustomDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.3,
      height: 1,
    );
  }
}
