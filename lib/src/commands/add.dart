import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart';

import '../args/global_args.dart';
import '../exceptions/app_exception.dart';
import '../git.dart';

/// Command that can be run from the cli
/// Launches a browser showing the mailhog interface.
class AddCommand extends Command<void> {
  /// name of the command. The user uses this name to run the command.
  @override
  String get name => 'add';

  @override
  String get description => '''
Add a file to the dotfile git repo.

Don't forget to commit the file.
''';

  @override
  Future<void> run() async {
    final args = AddArgs.parse(argResults, globalResults);

    final git = Git();

    final pathTo = args.pathTo;

    print(green('Adding $pathTo'));
    git.add(pathTo);
  }
}

/// Parse the command line args specific to the view command
/// including any global arguments.
class AddArgs extends GlobalArgs {
  AddArgs.parse(ArgResults? results, ArgResults? globalResults)
      : super(globalResults) {
    final rest = results!.rest;

    if (rest.isEmpty) {
      throw ExitException(
          1, 'add expects one argument with the path to the dotfile to add.',
          showUsage: true);
    }

    if (rest.length != 1) {
      throw ExitException(
          1,
          'add expects one argument with the path to the dotfile to add. '
          'Found: $rest',
          showUsage: true);
    }

    pathTo = rest[0];
  }

  late final String pathTo;
}
