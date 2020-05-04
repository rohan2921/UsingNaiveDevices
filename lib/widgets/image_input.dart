import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function f;
  ImageInput(this.f);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _addImage() async {
    final response = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 500,
    );
    if(response==null ) return;
    setState(() {
      
      _storedImage=response;
    });
    final appDir= await syspath.getApplicationDocumentsDirectory();
    final tempPath= path.basename(response.path);
    final savedImage=await response.copy('${appDir.path}/$tempPath');
    widget.f(savedImage);
    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(50)),
          child: _storedImage == null
              ? Text(
                  'No Image takken',
                  textAlign: TextAlign.center,
                )
              : ClipRRect(
                borderRadius: BorderRadius.circular(50),
                              child: Image.file(_storedImage,
                    fit: BoxFit.cover, width: double.infinity),
              ),
        ),
        SizedBox(width: 10),
        Expanded(
            child: FlatButton.icon(
          icon: Icon(Icons.add_a_photo),
          onPressed: 
            _addImage
          ,
          label: Text('Click a image'),
        ))
      ],
    );
  }
}
