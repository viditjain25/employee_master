import 'package:flutter/material.dart';
import 'package:lib_common/lib_common.dart';

import '../../../lib_style.dart';

class ScrollList<T> extends StatefulWidget {
  const ScrollList({
    Key? key,
    required this.isLoading,
    required this.itemBuilder,
    required this.group1Header,
    required this.group2Header,
    required this.itemGroup1,
    required this.itemGroup2,
    required this.noRecordFoundWidget,
    required this.controller,
    this.onRefresh,
  }) : super(key: key);
  final VoidCallback? onRefresh;
  final bool isLoading;
  final String group1Header;
  final String group2Header;
  final List<T> itemGroup1;
  final List<T> itemGroup2;
  final Widget noRecordFoundWidget;
  final ScrollController controller;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  State<ScrollList<T>> createState() => _ScrollListState<T>();
}

class _ScrollListState<T> extends State<ScrollList<T>> {
  late ScrollController _controller;
  Resources res = getIt<Resources>();

  @override
  void initState() {
    _controller = widget.controller;
    super.initState();
  }

  @override
  void dispose() {
    if (_controller.hasClients) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading &&
            widget.itemGroup1.isEmpty &&
            widget.itemGroup2.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: () async => widget.onRefresh?.call(),
            child: widget.itemGroup1.isEmpty &&
                    widget.itemGroup2.isEmpty &&
                    !widget.isLoading
                ? Center(
                    child: widget.noRecordFoundWidget,
                  )
                : CustomScrollView(
                    controller: _controller,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            if (widget.itemGroup1 != null && widget.itemGroup1.isNotEmpty) ...<Widget>[
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  widget.group1Header,
                                  style:
                                      res.themes.titleSmallFontSize16.copyWith(
                                    color: getIt<Resources>().themes.blue,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: ListTile.divideTiles(
                                  context: context,
                                  color: getIt<Resources>()
                                      .themes
                                      .lightGrey
                                      .withValues(alpha: 0.2),
                                  tiles: <Widget>[
                                    ...widget.itemGroup1
                                        .map(
                                          (_) => widget.itemBuilder(context, _),
                                        )
                                        .toList(),
                                  ],
                                ).toList(),
                              ),
                            ],
                            if (widget.itemGroup2 != null && widget.itemGroup2.isNotEmpty) ...<Widget>[
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  widget.group2Header,
                                  style:
                                      res.themes.titleSmallFontSize16.copyWith(
                                    color: getIt<Resources>().themes.blue,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: ListTile.divideTiles(
                                  context: context,
                                  color: getIt<Resources>()
                                      .themes
                                      .lightGrey
                                      .withValues(alpha: 0.2),
                                  tiles: <Widget>[
                                    ...widget.itemGroup2
                                        .map(
                                          (_) => widget.itemBuilder(context, _),
                                        )
                                        .toList(),
                                  ],
                                ).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
          );
  }
}
