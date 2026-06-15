import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/core/widgets/page_indicator_widget.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/domain/entities/main_banner_carousel_config_entity.dart';

class FeaturedEventCarouselWidget extends StatefulWidget {
  const FeaturedEventCarouselWidget({
    super.key,
    required this.events,
    required this.carouselConfig,
    this.onEventTap,
  });

  final List<EventEntity> events;
  final MainBannerCarouselConfigEntity carouselConfig;
  final ValueChanged<EventEntity>? onEventTap;

  @override
  State<FeaturedEventCarouselWidget> createState() =>
      FeaturedEventCarouselWidgetState();
}

class FeaturedEventCarouselWidgetState extends State<FeaturedEventCarouselWidget> {
  final PageController pageController = PageController();
  Timer? autoplayTimer;
  int activeIndex = 0;
  bool userInteracted = false;

  @override
  void initState() {
    super.initState();
    _startAutoplay();
  }

  @override
  void didUpdateWidget(FeaturedEventCarouselWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.events.length != widget.events.length ||
        oldWidget.carouselConfig.autoplayIntervalMs !=
            widget.carouselConfig.autoplayIntervalMs) {
      _restartAutoplay();
    }
  }

  @override
  void dispose() {
    autoplayTimer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  void _startAutoplay() {
    autoplayTimer?.cancel();
    if (widget.events.length <= 1) {
      return;
    }

    autoplayTimer = Timer.periodic(
      Duration(milliseconds: widget.carouselConfig.autoplayIntervalMs),
      (_) => _advanceToNextSlide(),
    );
  }

  void _restartAutoplay() {
    if (!userInteracted) {
      _startAutoplay();
    }
  }

  void _advanceToNextSlide() {
    if (!mounted || widget.events.length <= 1 || !pageController.hasClients) {
      return;
    }

    final nextIndex = (activeIndex + 1) % widget.events.length;
    pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  void _handleUserInteraction() {
    userInteracted = true;
    autoplayTimer?.cancel();
  }

  void _handlePageChanged(int index) {
    setState(() => activeIndex = index);
  }

  void _handleIndicatorTap(int index) {
    _handleUserInteraction();
    if (!pageController.hasClients) {
      return;
    }
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  double _resolveCardHeight(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final layout = ResponsiveLayout(context);
    final horizontalInset = layout.spacing(4);
    final width = screenSize.width - horizontalInset;
    final activeEvent = widget.events.isEmpty ? null : widget.events[activeIndex];
    final ratio = widget.carouselConfig.resolveAspectRatio(activeEvent?.aspectRatio);
    final ratioHeight = width / ratio;
    final minHeight = screenSize.height * widget.carouselConfig.heightScreenFractionMin;
    final maxHeight = screenSize.height * widget.carouselConfig.heightScreenFractionMax;
    return ratioHeight.clamp(minHeight, maxHeight);
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final cardHeight = _resolveCardHeight(context);

    if (widget.events.isEmpty) {
      return SizedBox(height: cardHeight);
    }

    return Column(
      children: [
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.events.length,
            onPageChanged: _handlePageChanged,
            itemBuilder: (context, index) {
              final event = widget.events[index];
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification &&
                      notification.dragDetails != null) {
                    _handleUserInteraction();
                  }
                  return false;
                },
                child: FeaturedEventCardWidget(
                  event: event,
                  onTap: widget.onEventTap == null
                      ? null
                      : () {
                          _handleUserInteraction();
                          widget.onEventTap!(event);
                        },
                ),
              );
            },
          ),
        ),
        SizedBox(height: layout.spacing(12)),
        PageIndicatorWidget(
          count: widget.events.length,
          activeIndex: activeIndex,
          onDotTap: _handleIndicatorTap,
        ),
      ],
    );
  }
}

class FeaturedEventCardWidget extends StatelessWidget {
  const FeaturedEventCardWidget({
    super.key,
    required this.event,
    this.onTap,
  });

  final EventEntity event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final subtitle = event.subtitle?.trim();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: layout.spacing(2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(layout.radius(16)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              EventNetworkImage(
                imageUrl: event.imageUrl,
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.homeCardScrimTop,
                      AppColors.homeCardScrimBottom,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(layout.spacing(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    if (subtitle != null && subtitle.isNotEmpty) ...[
                      AppText(
                        subtitle,
                        variant: AppTextVariant.bodyEmphasis,
                        color: AppColors.backgroundWhite,
                        fontSize: layout.fontSize(13),
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: layout.spacing(8)),
                    ],
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: AppColors.homeFeaturedTitleGradient,
                      ).createShader(bounds),
                      child: AppText(
                        event.title,
                        variant: AppTextVariant.title,
                        color: AppColors.backgroundWhite,
                        fontSize: layout.fontSize(22),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (event.dateTimeLabel.isNotEmpty) ...[
                      SizedBox(height: layout.spacing(10)),
                      FeaturedEventMetaRow(
                        icon: Icons.calendar_today_outlined,
                        label: event.dateTimeLabel,
                      ),
                    ],
                    if (event.locationLabel.isNotEmpty) ...[
                      SizedBox(height: layout.spacing(6)),
                      FeaturedEventMetaRow(
                        icon: Icons.location_on_outlined,
                        label: event.locationLabel,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedEventMetaRow extends StatelessWidget {
  const FeaturedEventMetaRow({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Row(
      children: [
        Icon(
          icon,
          size: layout.fontSize(14),
          color: AppColors.backgroundWhite,
        ),
        SizedBox(width: layout.spacing(6)),
        Expanded(
          child: AppText(
            label,
            variant: AppTextVariant.body,
            color: AppColors.backgroundWhite,
            fontSize: layout.fontSize(11),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
