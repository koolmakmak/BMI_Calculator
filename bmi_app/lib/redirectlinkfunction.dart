import 'package:url_launcher/url_launcher.dart';

String getAdviceRedirectLink(String bmiType) {
  switch (bmiType) {
    case 'Underweight':
      return 'https://spinthewheel.app/what-fast-food-ill-get';
    case 'Normal weight':
      return 'https://spinthewheel.app/dessert-wheel';
    case 'Overweight':
      return 'https://spinthewheel.app/healthy-meals-protein-and-carbs';
    case 'Obese':
      return 'https://spinthewheel.app/low-energy-meal-options';
    default:
      return 'https://spinthewheel.app/the-foods';
  }
}

Future<void> openRedirectLink(String url) async {
  final uri = Uri.parse(url);
  if (!await canLaunchUrl(uri)) {
    throw Exception('Could not open URL: $url');
  }
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
