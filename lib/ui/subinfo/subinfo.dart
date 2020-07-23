import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/ui/constants/form_c.dart';

enum PaymentStatus { paid, pending }

// ignore: must_be_immutable
class SubInfo extends StatefulWidget {
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
  SubInfo(
      {this.name,
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
  _SubInfoState createState() => _SubInfoState();
}

class _SubInfoState extends State<SubInfo> {
  PaymentStatus _c;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context, listen: false);

    if (widget.payStatus == 'Paid') {
      _c = PaymentStatus.paid;
    } else {
      _c = PaymentStatus.pending;
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
        title: GradientText(
          'Subscription Info',
          gradient: const LinearGradient(colors: [
            Color(0xFFFEB692),
            Color(0xFFEA5455),
          ]),
          style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Allura',
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(LineAwesomeIcons.trash),
              tooltip: 'Delete',
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
                    category: widget.category);
                db.deleteTask(sub);
                Navigator.pop(context);
              })
        ],
      ),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.89,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      autovalidate: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: TextFormField(
                              cursorColor: cursorColor,
                              initialValue: widget.charges == null
                                  ? ''
                                  : widget.charges.toString(),
                              onChanged: (v) {
                                widget.charges = double.parse(v);
                              },
                              style: TextStyle(
                                fontSize: 37,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
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
                              style: const TextStyle(fontSize: 22),
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
                          SizedBox(
                              // width: w * 0.87,
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Name'),
                              SizedBox(
                                height: h * 0.001,
                              ),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                cursorColor: cursorColor,
                                onChanged: (v) {
                                  widget.name = v;
                                },
                                initialValue:
                                    widget.name == null ? '' : widget.name,
                              ),
                            ],
                          )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          SizedBox(
                            // width: w * 0.87,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: const Text('Frequency')),
                                Expanded(
                                  flex: 1,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    value: widget.periodType,
                                    icon: Icon(LineAwesomeIcons.angle_down),
                                    items: const <String>[
                                      'Day',
                                      'Week',
                                      'Month',
                                      'Year'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text('   ' + value),
                                      );
                                    }).toList(),
                                    onChanged: (v) {
                                      setState(
                                        () {
                                          widget.periodType = v;
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h * 0.015,
                          ),
                          SizedBox(
                            // width: w * 0.87,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Payment Date'),
                                SizedBox(
                                  // width: w * 0.235,
                                  child: GestureDetector(
                                    onTap: () {
                                      return showDatePicker(
                                              context: context,
                                              firstDate: DateTime(2000),
                                              initialDate: DateTime.now(),
                                              lastDate: DateTime(2100))
                                          .then(
                                        (v) {
                                          setState(() {
                                            widget.payDate = v;
                                          });
                                        },
                                      );
                                    },
                                    child: Text(widget.payDate == null
                                        ? '${widget.firstPayment.day} - ${widget.firstPayment.month} - ${widget.firstPayment.year}'
                                        : ('${widget.payDate.day} - ${widget.payDate.month} - ${widget.payDate.year}')),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h * 0.023,
                          ),
                          const Text('Payment Status'),
                          SizedBox(
                            // width: w * 0.87,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text('Paid'),
                                    leading: Radio(
                                      activeColor: const Color(0xFFEA5455),
                                      value: PaymentStatus.paid,
                                      groupValue: _c,
                                      onChanged: (PaymentStatus value) {
                                        setState(
                                          () {
                                            widget.payStatus = 'Paid';

                                            _c = value;
                                          },
                                        );
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
                                        setState(
                                          () {
                                            widget.payStatus = 'Pending';
                                            _c = value;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: h * 0.02,
                          // ),
                          SizedBox(
                              // width: w * 0.87,
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Notes(optional)-'),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                cursorColor: cursorColor,
                                initialValue:
                                    widget.notes == null ? '' : widget.notes,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    widget.notes = value;
                                  });
                                },

                                //textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          SizedBox(
                            // width: w * 0.87,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Payment Info(optional)-'),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  cursorColor: cursorColor,
                                  onChanged: (v) {
                                    widget.payMethod = v;
                                  },
                                  initialValue: widget.payMethod == null
                                      ? ''
                                      : widget.payMethod,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          SizedBox(
                            //   width: w * 0.87,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Category(optional)-'),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  cursorColor: cursorColor,
                                  onChanged: (v) {
                                    widget.category = v;
                                  },
                                  initialValue: widget.category == null
                                      ? ''
                                      : widget.category,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
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
                                      color: const Color(0xFFF1f1f1)),
                                ),
                              ),
                            ),
                            onTap: () async {
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
                                  category: widget.category);
                              db.updateSub(sub);
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
