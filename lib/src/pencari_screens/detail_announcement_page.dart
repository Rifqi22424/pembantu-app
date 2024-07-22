import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../provider/announcement_provider.dart';

class DetailAnnouncementPage extends StatefulWidget {
  final int id;
  const DetailAnnouncementPage({super.key, required this.id});

  @override
  State<DetailAnnouncementPage> createState() => _DetailAnnouncementPageState();
}

class _DetailAnnouncementPageState extends State<DetailAnnouncementPage> {
  @override
  void initState() {
    super.initState();
    context.read<AnnouncementProvider>().getAnnouncementDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
        appBar: appBar(),
        body: Consumer<AnnouncementProvider>(
          builder: (context, value, child) {
            switch (value.state) {
              case AnnouncementState.loading:
                return Center(child: CircularProgressIndicator());
              case AnnouncementState.error:
                return Center(
                  child: Text(value.errorMessage ?? "an error has ocured"),
                );
              case AnnouncementState.loaded:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Text(value.announcement!.title),
                      // Text(value.announcement!.subTitle),
                      // Text(value.announcement!.createdAt),
                      // Text(value.announcement!.message ?? ""),
                      Padding(
                        padding: EdgeInsets.only(right: 16, left: 16, bottom: 20),
                        child: MarkdownBody(
                          data: value.announcement!.message ?? "",
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(Theme.of(context)),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return Container();
            }
          },
        ));
  }
}

class Markdown {}

class appBar extends StatelessWidget implements PreferredSizeWidget {
  const appBar({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Container(
            padding: EdgeInsets.all(4),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF5F5F5)),
            child: Center(
              child: Image.asset(
                'images/NavBackTransparant.png',
                color: Colors.black,
                height: 16,
                width: 16,
              ),
            ),
          )),
      title: Text(
        "Detail Notification",
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }
}
