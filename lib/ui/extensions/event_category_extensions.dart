import 'package:flutter/widgets.dart';
import 'package:yc_ankara_app/domain/models/event.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

extension EventCategoryExtension on EventCategory {
  String localizedLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case EventCategory.sports:
        return l10n.eventCategorySports;
      case EventCategory.culture:
        return l10n.eventCategoryCulture;
      case EventCategory.educational:
        return l10n.eventCategoryEducational;
      case EventCategory.social:
        return l10n.eventCategorySocial;
      case EventCategory.religious:
        return l10n.eventCategoryReligious;
      case EventCategory.other:
        return l10n.eventCategoryOther;
    }
  }
}
