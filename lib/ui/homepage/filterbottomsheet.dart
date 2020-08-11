import 'package:gradient_text/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/models/filter.dart';
import 'package:substracker/models/sort.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final Color c1 = const Color(0xFFFEB692);
  final Color c2 = const Color(0xFFEA5455);
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context);
    final filter = Provider.of<Filter>(context);
    final s = Provider.of<Sort>(context);
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildSizedBox(context),
        GradientText(
          'Filter',
          gradient: LinearGradient(colors: [c1, c2]),
          style: const TextStyle(
              fontSize: 25, letterSpacing: 1.4, fontWeight: FontWeight.bold),
        ),
        buildSizedBox(context),
        const Divider(),
        StreamBuilder(
          stream: db.getSubs(),
          builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
            final subs = snapshot.data ?? List(0);
            List<String> category = List<String>();
            subs.forEach((element) {
              if (element.category == null) {
              } else {
                category.add('All');
                category.add(element.category);
              }
              category = category.toSet().toList();
            });
            // print(category);
            return Container(
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (_, index) {
                    final item = category[index];
                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 08.0,
                      children: [
                        SizedBox(),
                        ActionChip(
                            label: Text(item == null ? '' : item),
                            onPressed: () {
                              if (item == 'All') {
                                s.changeSort('all');
                              } else {
                                s.changeSort('filter');
                                filter.changeFilter(item);
                              }
                              Navigator.of(context).pop();
                            }),
                        SizedBox(),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ]),
    );
  }

  SizedBox buildSizedBox(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

// ActionChip(
//                 label: Text('Entertainment'),
//                 onPressed: () {
//                   print("If you stand for nothing, Burr, what’ll you fall for?");
//                 }),
