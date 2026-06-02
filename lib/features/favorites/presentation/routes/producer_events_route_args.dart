class ProducerEventsRouteArgs {
  const ProducerEventsRouteArgs({
    required this.producerId,
    required this.producerName,
    required this.imageAssetPath,
  });

  final String producerId;
  final String producerName;
  final String imageAssetPath;
}
