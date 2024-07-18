import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingolearn_task_app/services/firebase_remote_config/firebase_remote_config_service.dart';
import 'package:pingolearn_task_app/services/firebase_remote_config/remote_config_keys.dart';
import 'package:pingolearn_task_app/utils/theme_data.dart';
import 'package:pingolearn_task_app/viewmodels/news_headlines_viewmodels/news_headlines_viewmodel.dart';
import 'package:pingolearn_task_app/viewmodels/remote_config_viewmodel/remote_config_viewmode.dart';
import 'package:pingolearn_task_app/widgets/ui_providers/loading_widget_provider.dart';
import 'package:provider/provider.dart';

import '../../../services/remote/news_headlines_service.dart';
import '../../../viewmodels/auth_viewmodels/auth_viewmodel.dart';
import '../news_headlines_widgets/news_headlines_list_tile.dart';

class NewsHeadlinesList extends StatefulWidget {
  const NewsHeadlinesList({super.key});

  @override
  State<NewsHeadlinesList> createState() => _NewsHeadlinesListState();
}

class _NewsHeadlinesListState extends State<NewsHeadlinesList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsHeadLineProvider>(context, listen: false)
          .getNewsHeadlines();
    });
    super.initState();
  }

  final remoteConfig = FirebaseRemoteConfigService();

  @override
  Widget build(BuildContext context) {
    // final locationProvider = Provider.of<FirebaseRemoteConfigProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyNews"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Row(
              children: [
                Icon(
                  CupertinoIcons.location_fill,
                  size: size.height * 0.024,
                  color: AppTheme.secondaryColor,
                ),
                Text(
                  remoteConfig.getLocationFromRemoteConfig(
                      RemoteConfigKeys.newsLocation),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor),
                )
              ],
            ),
          ),
          Gap(size.width * 0.02)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.02,
            right: size.width * 0.03,
            left: size.width * 0.03),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Top Headlines",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Gap(size.height * 0.02),
            Consumer<NewsHeadLineProvider>(
              builder: (context, newsHeadlinesProvider, child) => Expanded(
                child: newsHeadlinesProvider.isLoading == true
                    ? const CupertinoActivityIndicator()
                    : RefreshIndicator(
                        onRefresh: () async {
                          return await newsHeadlinesProvider.getNewsHeadlines();
                        },
                        child: ListView.separated(
                            itemBuilder: (context, i) => NewsHeadlinesListTile(
                                  newsHeadlines:
                                      newsHeadlinesProvider.newsHeadLines[i],
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(),
                            itemCount:
                                newsHeadlinesProvider.newsHeadLines.length),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
