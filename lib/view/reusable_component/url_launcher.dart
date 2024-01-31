class UrLauncherClass {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'smith@example.com',
    queryParameters: (<String, String>{
      'subject': 'Example Subject & Symbols are allowed!',
    }),
  );
}
