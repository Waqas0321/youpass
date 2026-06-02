import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/page_indicator_widget.dart';
import 'package:youpass/features/home/domain/entities/featured_event_entity.dart';

class FeaturedEventCarouselWidget extends StatefulWidget {
  const FeaturedEventCarouselWidget({
    super.key,
    required this.events,
  });

  final List<FeaturedEventEntity> events;

  @override
  State<FeaturedEventCarouselWidget> createState() =>
      FeaturedEventCarouselWidgetState();
}

class FeaturedEventCarouselWidgetState extends State<FeaturedEventCarouselWidget> {
  final PageController pageController = PageController();
  int activeIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final cardHeight = layout.spacing(190);

    return Column(
      children: [
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.events.length,
            onPageChanged: (index) => setState(() => activeIndex = index),
            itemBuilder: (context, index) {
              return FeaturedEventCardWidget(event: widget.events[index]);
            },
          ),
        ),
        SizedBox(height: layout.spacing(12)),
        PageIndicatorWidget(
          count: widget.events.length,
          activeIndex: activeIndex,
        ),
      ],
    );
  }
}

class FeaturedEventCardWidget extends StatelessWidget {
  const FeaturedEventCardWidget({
    super.key,
    required this.event,
  });

  final FeaturedEventEntity event;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: layout.spacing(2)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(layout.radius(16)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppAssetImage(
              assetPath: AppAssets.dummyImage,
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
                SizedBox(height: layout.spacing(10)),
                FeaturedEventMetaRow(
                  icon: Icons.calendar_today_outlined,
                  label: event.dateTimeLabel,
                ),
                SizedBox(height: layout.spacing(6)),
                FeaturedEventMetaRow(
                  icon: Icons.location_on_outlined,
                  label: event.locationLabel,
                ),
              ],
            ),
          ),
          ],
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
