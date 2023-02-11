import 'package:dcli_core/dcli_core.dart';
import 'package:path/path.dart';

/// List of common .dotfiles that if we find them we automatically add
///

final commonPaths = <String>[
  join(HOME, '.bashrc'),
  join(HOME, '.profile'),
];
