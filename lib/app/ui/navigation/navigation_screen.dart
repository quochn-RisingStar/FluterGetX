// ignore_for_file: use_key_in_widget_constructors, flutter_style_todos

import 'dart:math';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../resources/model/test_model.dart';
import '../ui.dart';

class NavigationScreen extends BaseScreen<NavigationController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildHeader(),
        _buildListView(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.all(16).copyWith(top: 50),
      child: const Center(
        child: Text('100'),
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.raw.length,
        itemBuilder: (BuildContext context, int index) {
          final TestModel item = controller.raw[index];
          return CustomItemWidget(
            id: item.id!.toString(),
            title: item.title!,
            body: item.body!,
            backgroundColor: Colors.blue,
          );
        },
      ),
    );
  }
}

class CustomItemWidget extends StatelessWidget {
  const CustomItemWidget({
    super.key,
    required this.id,
    required this.title,
    required this.body,
    this.backgroundColor = Colors.red,
  });

  final String id;
  final String title;
  final String body;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final int randomId = Random().nextInt(100);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
        color: backgroundColor,
      ),
      child: Column(
        children: <Widget> [
          Text(id, style: AppTextStyles.normalBold, textAlign: TextAlign.left),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Text(body,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 16),
          ImageFromUrl(
            imageUrl: 'https://picsum.photos/id/$randomId/400/300',
            radius: 20,
          ),
        ],
      ),
    );
  }
}

class ImageFromUrl extends StatelessWidget {
  const ImageFromUrl({
    required this.imageUrl,
    this.radius = 16,
    super.key,
  });

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow, width: 4),
        borderRadius: BorderRadius.circular(radius + 4),
      ),
      width: 300,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}
