import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/firestore/firestore_providers.dart';
import '../shared/cached_image_widget.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

class OversightCommitteesTimelineScreen extends ConsumerStatefulWidget {
  const OversightCommitteesTimelineScreen({super.key});

  @override
  ConsumerState<OversightCommitteesTimelineScreen> createState() =>
      _OversightCommitteesTimelineScreenState();
}

class _OversightCommitteesTimelineScreenState
    extends ConsumerState<OversightCommitteesTimelineScreen> {
  int? _selectedYear;

  @override
  Widget build(BuildContext context) {
    final yearsAsync = ref.watch(oversightCommitteeYearsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).pastOversightCommittees),
      ),
      body: yearsAsync.when(
        data: (years) {
          if (years.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context).noDataAvailable),
            );
          }

          // Auto-select first year if none selected
          if (_selectedYear == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() => _selectedYear = years.first);
            });
          }

          return Column(
            children: [
              // Year selector
              Container(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<int>(
                  initialValue: _selectedYear,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).selectYear,
                    border: OutlineInputBorder(),
                  ),
                  items: years.map((year) {
                    return DropdownMenuItem(value: year, child: Text('$year'));
                  }).toList(),
                  onChanged: (year) {
                    setState(() => _selectedYear = year);
                  },
                ),
              ),
              // Oversight committee members list
              if (_selectedYear != null)
                Expanded(child: _OversightCommitteeList(year: _selectedYear!)),
            ],
          );
        },
        error: (e, _) =>
            Center(child: Text('${AppLocalizations.of(context).error}: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _OversightCommitteeList extends ConsumerWidget {
  const _OversightCommitteeList({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final committeesAsync = ref.watch(oversightCommitteesByYearProvider(year));

    return committeesAsync.when(
      data: (committees) {
        if (committees.isEmpty) {
          return Center(
            child: Text(AppLocalizations.of(context).noMembersForYear),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            childAspectRatio: 0.75,
          ),
          itemCount: committees.length,
          itemBuilder: (context, index) {
            final c = committees[index];
            return InkWell(
              onTap: () async {
                final phone = c.phone.replaceAll(' ', '');
                final uri = Uri.parse(
                  'https://wa.me/${phone.replaceAll('+', '')}',
                );
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Large Circular Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: c.imageUrl.startsWith('http')
                          ? CachedImageWidget(
                              imageUrl: c.imageUrl,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              c.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name (Bold & Clean)
                  Text(
                    c.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Role (Grey & Thin)
                  Text(
                    c.role,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      error: (e, _) => Center(child: Text('Error: $e')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
