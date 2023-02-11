import 'dart:async';

import 'package:args/command_runner.dart';

import '../git.dart';

class CommitCommand extends Command<void> {
  @override
  String get name => 'commit';

  @override
  String get description => '''
Commits any updated dotfiles.
''';

  @override
  Future<void> run() async {
    Git().commit();
  }
}
