import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacki/cubits/comments/comments_cubit.dart';
import 'package:hacki/models/models.dart';
import 'package:hacki/screens/widgets/widgets.dart';
import 'package:hacki/styles/styles.dart';

class InThreadSearchIconButton extends StatelessWidget {
  const InThreadSearchIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentsCubit>.value(
      value: context.read<CommentsCubit>(),
      child: OpenContainer(
        closedColor: Palette.transparent,
        openColor: Theme.of(context).canvasColor,
        closedShape: const CircleBorder(),
        closedElevation: 0,
        openElevation: 0,
        transitionType: ContainerTransitionType.fadeThrough,
        closedBuilder: (BuildContext context, void Function() action) {
          return CustomDescribedFeatureOverlay(
            tapTarget: const Icon(
              Icons.search,
              color: Palette.white,
            ),
            feature: DiscoverableFeature.searchInThread,
            child: IconButton(
              tooltip: 'Search in thread',
              icon: const Icon(Icons.search),
              onPressed: action,
            ),
          );
        },
        openBuilder: (_, void Function({Object? returnValue}) action) {
          return BlocProvider<CommentsCubit>.value(
            value: context.read<CommentsCubit>(),
            child: BlocBuilder<CommentsCubit, CommentsState>(
              buildWhen: (CommentsState previous, CommentsState current) =>
                  previous.matchedComments != current.matchedComments,
              builder: (BuildContext context, CommentsState state) {
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).canvasColor,
                    elevation: 0,
                    leadingWidth: 0,
                    leading: const SizedBox.shrink(),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.pt8),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'Search in this thread',
                                suffixText:
                                    '${state.matchedComments.length} results',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              onChanged: context.read<CommentsCubit>().search,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            onPressed: action,
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      for (final int i in state.matchedComments)
                        CommentTile(
                          comment: state.comments.elementAt(i),
                          fetchMode: FetchMode.lazy,
                          actionable: false,
                          collapsable: false,
                          onTap: () {
                            action();
                            context.read<CommentsCubit>().scrollTo(
                                  index: i + 1,
                                  alignment: 0.1,
                                );
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}