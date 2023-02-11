import 'package:dcli/dcli.dart';
import 'package:path/path.dart';

import 'constants.dart';

class Git {
  static String baseCommand = 'git --git-dir=$pathToDotFileRepo --work-tree=/';

  /// disable showing untracked files as our working tree starts from /
  /// so everyfile in the file system is considered untracked.
  void hideUntracked() {
    '$baseCommand config --local status.showUntrackedFiles no'.run;
  }

  void init() {
    if (!exists(pathToDotFileRepo)) {
      createDir(pathToDotFileRepo, recursive: true);
    }
    '$baseCommand init'.run;
    hideUntracked();
  }

  void add(String path) {
    '$baseCommand add $path'.run;
  }

  void commit([String? message]) {
    if (message != null) {
      '$baseCommand commit -m "$message"'.run;
    } else {
      '$baseCommand commit'.run;
    }
  }

  /// Returns the list of tracked files.
  List<String> listTracked() => '$baseCommand ls-files'
      .toList(workingDirectory: rootPath)
      .map((pathTo) => join(rootPath, pathTo))
      .toList();

  String status(String pathTo) {
    final lines = '$baseCommand status $pathTo -s'.toList();

    if (lines.isEmpty) {
      return '';
    } else {
      final line = lines[0].trim();
      final parts = line.split(' ');
      return parts[0];
    }
  }

  /// returns the first line of the last log message.
  String lastLog(String pathTo) {
    final lines = '$baseCommand log -1 --format="%s" -- $pathTo'.toList();

    return lines.isEmpty ? '' : lines[0];
  }

  void run(List<String> args) {
    '$baseCommand ${args.join(' ')}'.run;
  }
}
