import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart';

import '../args/global_args.dart';
import '../git.dart';

class ListCommand extends Command<void> {
  @override
  String get name => 'list';

  @override
  String get description => '''
Display the list of tracked files
''';

  @override
  Future<void> run() async {
    ListArgs.parse(globalResults);
    final git = Git();
    git.listTracked().forEach((pathTo) => showFile(git, pathTo));
  }

  void showFile(Git git, String pathTo) {
    final status = git.status(pathTo);
    final log = orange(git.lastLog(pathTo));
    print(Format()
        .row([status, join(rootPath, pathTo), log], widths: <int>[2, 50]));
  }
}

/// Parse the command line args specific to the install command
/// including any global arguments.
class ListArgs extends GlobalArgs {
  ListArgs.parse(super.globalResults);
}
