import 'package:flutter/material.dart';
import 'package:lib_common/lib_common.dart';

import '../../../lib_style.dart';
import 'svg_image_widget.dart';

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({
    Key? key,
    this.title = '',
    this.svgImage = noEmployeeIcon,
  }) : super(key: key);
  final String title;
  final String svgImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: SvgImageWidget(
              svgImage: svgImage,
              height: 218,
              width: 261,
            ),
          ),
          if (title.isNotEmpty)
            Text(
              title,
              textAlign: TextAlign.center,
              style: getIt<Resources>().themes.titleLarge.copyWith(
                    color: getIt<Resources>().themes.lightBlack,
                  ),
            ),
        ],
      ),
    );
  }
}
