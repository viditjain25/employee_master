import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_common/lib_common.dart';

import '../../../lib_style.dart';
import 'loading_shimmer.dart';
import 'svg_image_widget.dart';

class EmployeeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmployeeAppBar({
    super.key,
    required this.title,
    required this.isEdit,
    required this.onDelete,
    this.shimmerDeleteIcon = false,
  });

  final String title;
  final bool isEdit;
  final VoidCallback? onDelete;
  final bool shimmerDeleteIcon;

  @override
  Widget build(BuildContext context) {
    final Resources res = getIt<Resources>();
    return AppBar(
      toolbarHeight: 60,
      title: Text(
        title,
        style: res.themes.titleLarge.copyWith(
          color: res.themes.white,
        ),
      ),
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColorDark,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      actions: isEdit
          ? <Widget>[
              LoadingShimmer(
                enabled: shimmerDeleteIcon,
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: onDelete,
                    child: const SvgImageWidget(
                      svgImage: deleteIcon,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
