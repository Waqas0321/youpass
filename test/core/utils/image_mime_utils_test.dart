import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/utils/image_mime_utils.dart';

void main() {
  test('fromPath returns jpeg by default', () {
    expect(ImageMimeUtils.fromPath('/tmp/photo.jpg'), 'image/jpeg');
    expect(ImageMimeUtils.fromPath('/tmp/photo.JPG'), 'image/jpeg');
  });

  test('fromPath returns png for png files', () {
    expect(ImageMimeUtils.fromPath('/tmp/photo.png'), 'image/png');
  });

  test('fromPath returns webp and heic types', () {
    expect(ImageMimeUtils.fromPath('/tmp/photo.webp'), 'image/webp');
    expect(ImageMimeUtils.fromPath('/tmp/photo.heic'), 'image/heic');
  });
}
