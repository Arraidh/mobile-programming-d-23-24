import 'package:flutter/material.dart';
import 'dart:core';

class BookFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? image;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedImage;
  final ValueChanged<String> onChangedDescription;

  const BookFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.image = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedImage,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Switch(
                value: isImportant ?? false,
                onChanged: onChangedImportant,
              ),
              Expanded(
                child: Slider(
                  value: (number ?? 0).toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (number) => onChangedNumber(number.toInt()),
                ),
              )
            ],
          ),
          buildTitle(),
          const SizedBox(height: 8),
          buildImage(),
          const SizedBox(height: 16),
          buildDescription(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: TextStyle(
      color: Colors.blue.shade900,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.blue.shade900),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
  );


  Widget buildImage() => TextFormField(
    maxLines: 1,
    initialValue: image,
    style: TextStyle(
      color: Colors.blue.shade900,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'image url',
      hintStyle: TextStyle(color: Colors.blue.shade900),
    ),
    validator: (image) => image != null && image.isEmpty ? 'The image url cannot be empty' : getUrlType(image).name != 'IMAGE' ? 'Should enter an image URL of PNG JPG or JPEG' : null,

    onChanged: onChangedImage,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style:  TextStyle(color: Colors.blue.shade900, fontSize: 18),
    decoration:  InputDecoration(
      border: InputBorder.none,
      hintText: 'Type something...',
      hintStyle: TextStyle(color: Colors.blue.shade900),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedDescription,
  );



}

enum UrlType { IMAGE, UNKNOWN }


UrlType getUrlType(String? url) {
  Uri uri = Uri.parse(url!);
  String typeString = uri.path.substring(uri.path.length - 4).toLowerCase();
  if (typeString.contains('jpg') || typeString.contains('jpeg') || typeString.contains('ppg')) {
    return UrlType.IMAGE;
  } else {
    return UrlType.UNKNOWN;
  }
}