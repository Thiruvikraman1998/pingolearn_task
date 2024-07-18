import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingolearn_task_app/models/news_headlines_model.dart';
import 'package:pingolearn_task_app/utils/theme_data.dart';

import '../../../utils/util_methods.dart';

class NewsHeadlinesListTile extends StatelessWidget {
  final NewsHeadlinesModel newsHeadlines;

  const NewsHeadlinesListTile({super.key, required this.newsHeadlines});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 0,
      color: AppTheme.secondaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.02),
        height: size.height * 0.16,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      newsHeadlines.source!.name ?? "No Source",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    newsHeadlines.title ?? "Description unavailable",
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      timeAgo(newsHeadlines.publishedAt!),
                      style: const TextStyle(
                          color: AppTheme.greyTextColor,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            ),
            Gap(size.width * 0.04),
            Container(
              height: size.height * 0.14,
              width: size.width * 0.28,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(size.height * 0.02),
                ),
                image: DecorationImage(
                    image: newsHeadlines.urlToImage != null
                        ? NetworkImage("${newsHeadlines.urlToImage}")
                        : const AssetImage(
                            "assets/placeholders/news_image_placeholder.jpg"),
                    fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
    );
  }
}
