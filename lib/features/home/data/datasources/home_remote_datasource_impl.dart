import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/home/data/datasources/home_mock_data.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource.dart';
import 'package:youpass/features/home/data/models/home_feed_model.dart';
import 'package:youpass/l10n/app_localizations.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({this.locale = AppLocale.english});

  final Locale locale;

  @override
  Future<HomeFeedModel> fetchHomeFeed() async {
    await Future<void>.delayed(AppConstants.homeMockFetchDelay);

    final l10n = lookupAppLocalizations(locale);

    return HomeMockData.buildFeed(
      labels: AppStrings.homeFeedLabels(l10n),
    );
  }
}
