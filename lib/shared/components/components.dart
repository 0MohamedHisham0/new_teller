import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onChange,
  Function? onSubmit,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      onTap: () {
        onTap!();
      },
      validator: (value) {
        validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? HoldDetector(
                onHold: () {
                  suffix = Icons.speaker_phone_rounded;
                },
                child: IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(
                    suffix,
                  ),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

Widget sizedBox({double? height, double? width}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

Widget newsItem(article, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.grey[200]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: "${article['urlToImage']}",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 100,
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("${article['title'] ?? "No title available for this News"}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 2),
            sizedBox(height: 9),
            Text(
                "${article['description'] ?? "No Description available for this News"}",
                style: const TextStyle(fontSize: 16),
                maxLines: 3),
            sizedBox(height: 9),
            Text(
              "${article['publishedAt'] ?? "No Date available for this News"} - ${article['author'] ?? "No author available for this News"}",
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
            )
          ],
        ),
      ),
    ),
  );
}
