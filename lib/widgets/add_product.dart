import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<PickedFile> _imageFileList = [];
  dynamic _pickImageError;
  String _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  List<String> categories = ['Cat1', 'Cat2'];
  String selectedCategory = 'Cat1';

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
        );
        setState(() {
          _imageFileList.add(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList.isNotEmpty) {
      return Container(
        height: 100,
        width: MediaQuery.of(context).size.width - 20,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return Container(
                height: 100,
                width: 100,
                child:
                    ListTile(title: Image.file(File(_imageFileList[i].path))));
          },
          itemCount: _imageFileList.length,
          shrinkWrap: true,
        ),
      );
      // return Semantics(
      //     child: Image.file(File(_imageFile.path)),
      //     label: 'image_picker_example_picked_image');
    } else if (_pickImageError != null) {
      return Container();
    } else {
      return Container();
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (!_imageFileList.contains(response.file)) {
          _imageFileList.add(response.file);
        }
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ListTile(
                  title: Text('Product Images'),
                  subtitle: Column(
                    children: [
                      Container(
                        child: defaultTargetPlatform == TargetPlatform.android
                            ? FutureBuilder<void>(
                                future: retrieveLostData(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<void> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.waiting:
                                      return Container();
                                    case ConnectionState.done:
                                      return _previewImage();
                                    default:
                                      if (snapshot.hasError) {
                                        return Container();
                                      } else {
                                        return Container();
                                      }
                                  }
                                },
                              )
                            : (_previewImage()),
                      ),
                      RaisedButton(
                        child: Text('Add product Image'),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 200,
                                child: ListTile(
                                  title: Text('Choose Option'),
                                  subtitle: Column(
                                    children: [
                                      RaisedButton(
                                        onPressed: () {
                                          _onImageButtonPressed(
                                              ImageSource.camera,
                                              context: context);
                                        },
                                        child: Text('Take a picture'),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          _onImageButtonPressed(
                                              ImageSource.gallery,
                                              context: context);
                                        },
                                        child: Text('Choose from Gallery'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'MRP'),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Selling Price'),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Product Description'),
                  ),
                ),
                DropdownButton(
                  items: categories
                      .map((item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  value: selectedCategory,
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('Add Product'),
          )
        ],
      ),
    );
  }
}

// class ImagePreview extends StatefulWidget {
//   ImagePreview({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _ImagePreviewState createState() => _ImagePreviewState();
// }

// class _ImagePreviewState extends State<ImagePreview> {
//   PickedFile _imageFile;
//   dynamic _pickImageError;
//   String _retrieveDataError;
//   final ImagePicker _picker = ImagePicker();

//   void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
//     {
//       try {
//         final pickedFile = await _picker.getImage(
//           source: source,
//         );
//         setState(() {
//           _imageFile = pickedFile;
//         });
//       } catch (e) {
//         setState(() {
//           _pickImageError = e;
//         });
//       }
//     }
//   }

//   Widget _previewImage() {
//     final Text retrieveError = _getRetrieveErrorWidget();
//     if (retrieveError != null) {
//       return retrieveError;
//     }
//     if (_imageFile != null) {
//       return Semantics(
//           child: Image.file(File(_imageFile.path)),
//           label: 'image_picker_example_picked_image');
//     } else if (_pickImageError != null) {
//       return Text(
//         'Pick image error: $_pickImageError',
//         textAlign: TextAlign.center,
//       );
//     } else {
//       return const Text(
//         'You have not yet picked an image.',
//         textAlign: TextAlign.center,
//       );
//     }
//   }

//   Future<void> retrieveLostData() async {
//     final LostData response = await _picker.getLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       setState(() {
//         _imageFile = response.file;
//       });
//     } else {
//       _retrieveDataError = response.exception.code;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: defaultTargetPlatform == TargetPlatform.android
//             ? FutureBuilder<void>(
//                 future: retrieveLostData(),
//                 builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.none:
//                     case ConnectionState.waiting:
//                       return const Text(
//                         'You have not yet picked an image.',
//                         textAlign: TextAlign.center,
//                       );
//                     case ConnectionState.done:
//                       return _previewImage();
//                     default:
//                       if (snapshot.hasError) {
//                         return Text(
//                           'Pick image/video error: ${snapshot.error}}',
//                           textAlign: TextAlign.center,
//                         );
//                       } else {
//                         return const Text(
//                           'You have not yet picked an image.',
//                           textAlign: TextAlign.center,
//                         );
//                       }
//                   }
//                 },
//               )
//             : (_previewImage()),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Semantics(
//             label: 'image_picker_example_from_gallery',
//             child: FloatingActionButton(
//               onPressed: () {
//                 _onImageButtonPressed(ImageSource.gallery, context: context);
//               },
//               heroTag: 'image0',
//               tooltip: 'Pick Image from gallery',
//               child: const Icon(Icons.photo_library),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _onImageButtonPressed(ImageSource.camera, context: context);
//               },
//               heroTag: 'image1',
//               tooltip: 'Take a Photo',
//               child: const Icon(Icons.camera_alt),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Text _getRetrieveErrorWidget() {
//     if (_retrieveDataError != null) {
//       final Text result = Text(_retrieveDataError);
//       _retrieveDataError = null;
//       return result;
//     }
//     return null;
//   }
// }
