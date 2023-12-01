enum Routes {
  splash(path: '/splash'),
  weather(path: '/weather'),
  ;

  const Routes({required this.path});

  final String path;
}
