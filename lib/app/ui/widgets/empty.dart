
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';

class LoadMoreEmpty extends StatelessWidget {

  const LoadMoreEmpty({super.key, this.height,});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: height ?? Get.height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.png('errors'), scale: 3, color: AppColors.primary,),
            const SizedBox(height: 16,),
            Text('Không có dữ liệu', style: AppTextStyles.normalSemiBold,),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
