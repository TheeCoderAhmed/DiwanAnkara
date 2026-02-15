
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

import '../shared/cached_image_widget.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

enum ProjectActionType {
  none,
  contact, // Phone call
  whatsapp, // WhatsApp message
}

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.actionType = ProjectActionType.none,
    this.contactName,
    this.contactNumber,
    this.whatsappLink,
  });

  final String title;
  final String description;
  final String? imageUrl;
  final ProjectActionType actionType;
  
  // For contact action
  final String? contactName;
  final String? contactNumber;
  
  // For whatsapp action
  final String? whatsappLink;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark app background
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 420, // Generous height for the image
            backgroundColor: const Color(0xFF0F172A),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(LucideIcons.arrowRight, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            title: Text(
              AppLocalizations.of(context).projectDetails,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(color: Colors.black54, blurRadius: 4),
                ],
              ),
            ),
            centerTitle: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // 1. Blurred Background (Fills the space nicely)
                  if (imageUrl != null && imageUrl!.startsWith('http'))
                    CachedImageWidget(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(color: const Color(0xFF1E293B)),
                    
                  // Blur Effect over the background
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.4), // Darken the blur
                      ),
                    ),
                  ),

                  // 2. The Actual Clear Image (Centered & Contained)
                  // We add padding at top to account for the AppBar height + spacing
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                      child: Container(
                        // Limit height so it doesn't look stretched or too huge
                        constraints: const BoxConstraints(maxHeight: 360), 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: imageUrl != null && imageUrl!.startsWith('http')
                            ? CachedImageWidget(
                                imageUrl: imageUrl!,
                                fit: BoxFit.contain,
                              )
                            : const SizedBox(
                                height: 200, 
                                width: 200,
                                child: Icon(LucideIcons.image, size: 64, color: Colors.white54),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Details Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // Action Card
                  if (actionType != ProjectActionType.none)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          if (actionType == ProjectActionType.contact) ...[
                            if (contactName != null)
                              Row(
                                children: [
                                  const Icon(LucideIcons.user, color: Colors.white70),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      contactName!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => _launchUrl('tel:$contactNumber'),
                                icon: const Icon(LucideIcons.phone),
                                label: Text(contactNumber ?? AppLocalizations.of(context).callNow),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D9488),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          
                          if (actionType == ProjectActionType.whatsapp)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (whatsappLink != null) {
                                    _launchUrl(whatsappLink!);
                                  }
                                },
                                icon: const Icon(LucideIcons.messageCircle), 
                                label: Text(AppLocalizations.of(context).joinWhatsappGroup),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF25D366), 
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                    
                  const SizedBox(height: 32),
                  
                  // Description Title
                  Text(
                    AppLocalizations.of(context).aboutProject,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                  
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
