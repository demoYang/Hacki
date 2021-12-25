import 'package:flutter/material.dart';
import 'package:hacki/models/models.dart';
import 'package:hacki/screens/widgets/custom_circular_progress_indicator.dart';
import 'package:hacki/screens/widgets/story_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ItemsListView<T extends Item> extends StatelessWidget {
  const ItemsListView({
    Key? key,
    required this.refreshController,
    required this.items,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onTap,
  }) : super(key: key);

  final List<T> items;
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoadMore;
  final Function(Story) onTap;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullUp: true,
      header: const WaterDropMaterialHeader(
        backgroundColor: Colors.orange,
      ),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text('');
          } else if (mode == LoadStatus.loading) {
            body = const CustomCircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text(
              'loading failed.',
            );
          } else if (mode == LoadStatus.canLoading) {
            body = const Text(
              'loading more.',
            );
          } else {
            body = const Text('');
          }
          return SizedBox(
            height: 55,
            child: Center(child: body),
          );
        },
      ),
      controller: refreshController,
      onRefresh: onRefresh,

      onLoading: onLoadMore,
      child: ListView(
        children: [
          ...items.map((e) {
            if (e is Story) {
              return [
                StoryTile(
                  story: e,
                  onTap: () => onTap(e),
                ),
                const Divider(
                  height: 0,
                ),
              ];
            }

            return [Container()];
          }).expand((element) => element),
        ],
      ),
    );
  }
}