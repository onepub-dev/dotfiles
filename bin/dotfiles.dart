#! /usr/bin/env dcli

import 'package:args/command_runner.dart';
import 'package:dotfiles/src/args/usage.dart';
import 'package:dotfiles/src/commands/add.dart';
import 'package:dotfiles/src/commands/commit.dart';
import 'package:dotfiles/src/commands/init.dart';
import 'package:dotfiles/src/commands/list.dart';
import 'package:dotfiles/src/git.dart';

void main(List<String> args) async {
  // add set of supported commands
  final runner = CommandRunner<void>(
      'dotfiles', 'Manages all of your .dotfiles in a git repo')
    ..addCommand(CommitCommand())
    ..addCommand(InitCommand())
    ..addCommand(ListCommand())
    ..addCommand(AddCommand());

  /// Add global options available to all commands
  /// NOTE: update args/global_args.dart to parse any flags/options
  /// you add here.
  runner.argParser.addFlag('debug',
      abbr: 'd',
      help: 'Output verbose debugging information',
      negatable: false);

  try {
    // parse the cli options passed and run the selected command.
    await runner.run(args);
    // ignore: avoid_catches_without_on_clauses
  } on UsageException catch (e) {
    if (e.message.startsWith('Could not find a command named')) {
      Git().run(args);
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    showException(runner, e);
  }
}
