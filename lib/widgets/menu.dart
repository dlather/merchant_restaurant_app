import 'package:flutter/material.dart';
import './add_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<dynamic> firebaseData = [];
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // fetchData() {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection('test_stream').doc('test_doc_id');
  //   documentReference.snapshots().listen((event) {
  //     print(event.data()['data'].toString());
  //     setState(() {
  //       data = event.data()['data'];
  //     });
  //   });
  // }

  getStream() {
    return FirebaseFirestore.instance
        .collection('test_stream')
        .doc('test_doc_id')
        .snapshots();
  }

  // List<dynamic> data = [
  //   {
  //     'category': 'Cat1',
  //     'items': [
  //       {
  //         'name': 'Item1',
  //         'price': '120',
  //       },
  //       {
  //         'name': 'Item2',
  //         'price': '12',
  //       }
  //     ]
  //   },
  //   {
  //     'category': 'Cat2',
  //     'items': [
  //       {
  //         'name': 'Item3',
  //         'price': '120',
  //       },
  //       {
  //         'name': 'Item4',
  //         'price': '12',
  //       },
  //       {
  //         'name': 'Item7',
  //         'price': '120',
  //       },
  //       {
  //         'name': 'Item8',
  //         'price': '120',
  //       },
  //       {
  //         'name': 'Item9',
  //         'price': '120',
  //       },
  //       {
  //         'name': 'Item10',
  //         'price': '120',
  //       },
  //       {
  //         'name': 'Item11',
  //         'price': '120',
  //       },
  //       {
  //         'name': 'Item12',
  //         'price': '120',
  //       },
  //     ]
  //   },
  //   {
  //     'category': 'Cat3',
  //     'items': [
  //       {
  //         'name': 'Item5',
  //         'price': '120',
  //       },
  //       {
  //         'name': 'Item6',
  //         'price': '12',
  //       }
  //     ]
  //   }
  // ];

  List<dynamic> expandedTiles = [];

  void _updateCat(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final dynamic item = data.removeAt(oldIndex);
    data.insert(newIndex, item);
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('test_stream').doc('test_doc_id');
    await documentReference.update({"data": data});

    setState(
      () {},
    );
  }

  void _updateItems(int oldIndex, int newIndex, String category) async {
    for (Map res in data) {
      if (res['category'] == category) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final dynamic item = res['items'].removeAt(oldIndex);
        res['items'].insert(newIndex, item);
      }
    }
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('test_stream').doc('test_doc_id');
    await documentReference.update({"data": data});
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          data = snapshot.data['data'];
          return Column(
            children: [
              Expanded(
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    _updateCat(oldIndex, newIndex);
                  },
                  children: [
                    for (final catResult in data)
                      ExpansionTile(
                        key: ValueKey(catResult['category'] + '-ExpansionTile'),
                        title: Text(catResult['category']),
                        initiallyExpanded:
                            expandedTiles.contains(catResult['category']),
                        onExpansionChanged: (value) {
                          if (value) {
                            expandedTiles.add(catResult['category']);
                          } else {
                            expandedTiles.remove(catResult['category']);
                          }
                        },
                        children: [
                          Container(
                            height: 400,
                            child: ReorderableListView(
                              key: ValueKey(catResult['category'] +
                                  '-ReorderableListView'),
                              scrollController: ScrollController(
                                initialScrollOffset: 50,
                              ),
                              children: [
                                for (final itemResult in catResult['items'])
                                  ListTile(
                                    key: ValueKey(itemResult['name']),
                                    title: Text(itemResult['name']),
                                  ),
                              ],
                              onReorder: (oldIndex, newIndex) {
                                _updateItems(
                                    oldIndex, newIndex, catResult['category']);
                              },
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AddProduct();
                      },
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }

// OLD IS GOLD

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       Expanded(
  //         child: ReorderableListView(
  //           onReorder: (oldIndex, newIndex) {
  //             _updateCat(oldIndex, newIndex);
  //           },
  //           children: [
  //             for (final catResult in data)
  //               ExpansionTile(
  //                 key: ValueKey(catResult['category'] + '-ExpansionTile'),
  //                 title: Text(catResult['category']),
  //                 initiallyExpanded: expandedTiles.contains(catResult),
  //                 onExpansionChanged: (value) {
  //                   if (value) {
  //                     expandedTiles.add(catResult);
  //                   } else {
  //                     expandedTiles.remove(catResult);
  //                   }
  //                 },
  //                 children: [
  //                   Container(
  //                     height: 400,
  //                     child: ReorderableListView(
  //                       key: ValueKey(
  //                           catResult['category'] + '-ReorderableListView'),
  //                       scrollController: ScrollController(
  //                         initialScrollOffset: 50,
  //                       ),
  //                       children: [
  //                         for (final itemResult in catResult['items'])
  //                           ListTile(
  //                             key: ValueKey(itemResult['name']),
  //                             title: Text(itemResult['name']),
  //                           ),
  //                       ],
  //                       onReorder: (oldIndex, newIndex) {
  //                         _updateItems(
  //                             oldIndex, newIndex, catResult['category']);
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               )
  //           ],
  //         ),
  //       ),
  //       RaisedButton(
  //         child: Text('Add'),
  //         onPressed: () {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) {
  //                 return AddProduct();
  //               },
  //             ),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }
}
