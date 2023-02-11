import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:dcli_core/dcli_core.dart';

import '../args/global_args.dart';
import '../common.dart';
import '../git.dart';

class InitCommand extends Command<void> {
  InitCommand();

  // command options

  /// name of the command. The user uses this name to run the command.
  @override
  String get name => 'init';

  @override
  String get description => '''
Initialises a git repo in $HOME/.dotfiles to manage all of you system wide .dotfiles
''';

  /// run the installation.
  @override
  Future<void> run() async {
    InitArgs.parse(globalResults);

    final git = Git()..init();

    var added = false;
    for (final path in commonPaths) {
      if (exists(path)) {
        git.add(path);
        added = true;
      }
    }

    if (added) {
      git.commit('Initial commit of common files');
    }
  }
}

/// Parse the command line args specific to the install command
/// including any global arguments.
class InitArgs extends GlobalArgs {
  InitArgs.parse(super.globalResults);
}
