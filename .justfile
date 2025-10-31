set shell := ["bash", "-c"]

# default recipe to display help information
@list:
  just --list

# remove files created by tooling and packaging
@clean:
  rm -rf build

# install flutter dependencies
install:
    flutter pub get

# run linter and formatter
lint: install
    flutter analyze
    flutter format --set-exit-if-changed .
