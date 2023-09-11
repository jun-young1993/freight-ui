import 'package:flutter/material.dart';
import 'package:freight_ui/config/main_app_bar.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/utills/size.dart';

const double mainAppbarPadding = MainAppBarConfig.mainAppBarPadding;


class MainSliverAppBar extends SliverAppBar{
  static const TextStyle _textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: kToolbarHeight / 3, height : 1);
  
  MainSliverAppBar({
      GlobalKey? appBarKey,
      String title = "", //AppConstants.name,
      double height = kToolbarHeight + mainAppbarPadding * 2,
      double expandedFontSize = 30,
      IconData leadingIconData = Icons.arrow_back,
      void Function()? onLeadingPress = AppNavigator.pop,
      List<Widget>? tailActions,
      required BuildContext context, Color? color, Color? backgroundColor})
      : super(
          centerTitle: true,
          expandedHeight: height,
          floating: false,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.symmetric(horizontal: mainAppbarPadding),
            onPressed: onLeadingPress,
            icon: Icon(
              leadingIconData,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          actions: tailActions ?? [],
          // [
            // IconButton(
            //   padding: EdgeInsets.symmetric(horizontal: mainAppbarPadding),
            //   icon: Icon(Icons.favorite_border_outlined,
            //       color: Theme.of(context).textTheme.bodyLarge!.color),
            //   onPressed: onTrailingPress,
            // ),
          // ],
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final safeAreaTop = MediaQuery.of(context).padding.top;
              final minHeight = safeAreaTop + kToolbarHeight;
              final maxHeight = height + safeAreaTop;

              final percent = (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
              final fontSize = _textStyle.fontSize ?? 16;
              final currentTextStyle = _textStyle.copyWith(
                fontSize: fontSize + (expandedFontSize - fontSize) * percent,
              );

              final textWidth = getTextSize(context, title, currentTextStyle).width;
              final startX = mainAppbarPadding;
              final endX = MediaQuery.of(context).size.width / 2 - textWidth / 2 - startX;
              final dx = startX + endX - endX * percent;

              return Container(
                color: Theme.of(context).backgroundColor.withOpacity(0.8 - percent * 0.8),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: kToolbarHeight / 3),
                      child: Transform.translate(
                        child: Text(
                          title,
                          style: currentTextStyle,
                        ),
                        offset: Offset(dx, constraints.maxHeight - kToolbarHeight),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
}
