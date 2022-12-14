import 'dart:convert';
import 'dart:io';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';

import '../model/image_model.dart';

class Images extends StatefulWidget {
  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StoragePath.imagesPath,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<dynamic> list = json.decode(snapshot.data);

          return Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                ImageModel imageModel = ImageModel.fromJson(list[index]);
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FolderAllImages(data:imageModel.files! ,)));
                  },
                  child: Container(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        FadeInImage(
                          image: FileImage(
                            File(imageModel.files![0]),
                          ),
                          placeholder: MemoryImage(kTransparentImage),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.7),
                          height: 30,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              imageModel.folderName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Regular'
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FolderAllImages extends StatelessWidget {
  var data;
   FolderAllImages({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          // ImageModel imageModel = ImageModel.fromJson(list[index]);
          return GestureDetector(
            child: Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  FadeInImage(
                    image: FileImage(
                      File(data[index]),
                    ),
                    placeholder: MemoryImage(kTransparentImage),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // Container(
                  //   color: Colors.black.withOpacity(0.7),
                  //   height: 30,
                  //   width: double.infinity,
                  //   child: Center(
                  //     child: Text(
                  //       imageModel.folderName!,
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //           fontFamily: 'Regular'
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
