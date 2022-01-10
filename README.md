# Overview

Quickly yank text into your current command while typing.

Yankee understands the context of your current command and offers you an interactive menu of
from which to select objects that you would like to insert into your command line.

<!-- screencast of demo here -->

# Installation

```
git clone https://github.com/dhamidi/yankee /tmp/yankee
pushd /tmp/yankee
sudo make install 
# or make install PREFIX=$HOME/.local or some other path
```

# Dependencies

The built-in completions require `fzf` to work.

# How does it work?

Yankee hooks into your shell and when you press <kbd>Ctrl+y</kbd> it scans your current 
command line to offer context-sensitive options, before pasting them at your current cursor position.

## Isn't that just auto-completion?

Basically yes, but here is how it differs:

* extend it in any language, not just shell
* full control over your current command line,
* show rich previews of completed objects, not just text.



