class BasePath {
  final String path;
  final BasePath? root;

  const BasePath(this.path, [this.root]);

  String get completePath {
    final base = root?.completePath ?? '';
    return '$base${!base.endsWith('/') ? path : path.replaceFirst('/', '')}';
  }
}
