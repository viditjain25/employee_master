import 'package:flutter/material.dart';
import 'package:lib_common/lib_common.dart';
import 'package:lib_style/lib_style.dart';

class DesignationMenu extends StatelessWidget {
  const DesignationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).canvasColor,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => getIt<NavigationService>()
                  .goBack(result: designationList[index]),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  child: Text(
                    designationList[index],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: getIt<Resources>().themes.lightGrey,
              thickness: 0.1,
            );
          },
          itemCount: designationList.length,
        ),
      ),
    );
  }
}
