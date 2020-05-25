import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectedImage;

  ImageInput({this.onSelectedImage});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File storedImage;

  Future<void> takePicture() async {
    final imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }

    setState(() {
      storedImage = imageFile;
    });
    final appDirectory = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDirectory.path}/$fileName');
    widget.onSelectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 150,
        height: 100,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: storedImage != null
            ? Image.file(
                storedImage,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Text(
                "No Image Taken",
                textAlign: TextAlign.center,
              ),
        alignment: Alignment.center,
      ),
      SizedBox(width: 10),
      Expanded(
          child: FlatButton.icon(
        onPressed: takePicture,
        icon: Icon(Icons.camera),
        label: Text("Take Picture"),
        textColor: Theme.of(context).primaryColor,
      ))
    ]);
  }
}
