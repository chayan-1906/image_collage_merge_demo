import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as image;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:skywa_framework_widgets/skywa_appbar.dart';
import 'package:skywa_framework_widgets/skywa_floating_action_button.dart';
import 'package:skywa_framework_widgets/skywa_loader.dart';

class ImageCollageScreen extends StatefulWidget {
  const ImageCollageScreen({Key key}) : super(key: key);

  @override
  State<ImageCollageScreen> createState() => _ImageCollageScreenState();
}

class _ImageCollageScreenState extends State<ImageCollageScreen> {
  List<File> images = [];
  File pickedImage;
  bool isLoading = false;
  File mergedImageeee;

  Future<void> mergeImage() async {
    setState(() {
      isLoading = false;
    });
    final image1 = image.decodeImage(images[0].readAsBytesSync());
    final image2 = image.decodeImage(images[1].readAsBytesSync());
    final mergedImage = image.Image(
      image1.width + image2.width,
      max(image1.height, image2.height),
    );
    image.copyInto(mergedImage, image1, blend: false);
    image.copyInto(mergedImage, image2, dstX: image1.width, blend: false);
    final documentDirectory = await getApplicationDocumentsDirectory();
    final File file = File(join(documentDirectory.path, "merged_image.jpg"));
    file.writeAsBytesSync(image.encodeJpg(mergedImage));
    print(file.path);
    setState(() {
      isLoading = false;
      mergedImageeee = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SkywaAppBar(appbarText: 'Image Collage'),
      ),
      body: isLoading
          ? const SkywaLoader()
          : Center(
              child: mergedImageeee != null
                  ? GestureDetector(
                      onTap: () {
                        ShareExtend.share(mergedImageeee.path, 'file');
                      },
                      child: Image.file(mergedImageeee),
                    )
                  : Container(),
            ),
      floatingActionButton: SkywaFloatingActionButton(
        iconData: Icons.add_rounded,
        onTap: () async {
          XFile pickedImage =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          images.add(File(pickedImage.path));
          print(images.length);
          if (images.length >= 2) {
            mergeImage();
          }
        },
      ),
    );
  }
}
