<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## 1.0.1 - 2023-09-17

### Added

- Ghost tapping, a pretty common feature for most FNF engines.

### Changed

- Reverted license to Apache License 2.0.

## 1.0.0 - Early October 2023

### Added

- Friday Night Funkin' (the game).
- WIP modding support, powered by Polymod. It's a rework, we all know.
- Visual Studio Code workspace files.
- [lix](https://github.com/lix-pm/lix.client) support.
- [Haxe Checkstyle](https://github.com/HaxeCheckstyle/haxe-checkstyle) settings.
- Implemented [hxCodec](https://github.com/polybiusproxy/hxCodec) for playing videos natively, also videos are now optional.
- Slightly more softcoded dialogue, still only Senpai though.
- Credits menu.
- New options: Note Splashes, Ghost Tapping and Antialiasing.

### Changed

- Cleaned up `Project.xml`.
- Slightly better performance.
- Re-enabled Discord Rich Presence for CPP builds.
- Updated Haxe and libraries to the latest versions.
- The starting note splash for precaching is now more transparent.
- Some code has reorganized.

### Removed

- Unused files, such as images, spritesheets, sounds, and data.
- Unneeded libraries from `Project.xml`, except `tjson` and `format`, might use these for later.
- Newgrounds support, as this won't be published on Newgrounds.
- MP3 files for HTML5 builds. OGG files are used instead.
- "Newgrounds exclusive preview" text on main menu.

### Fixed

- Title screen not having a fade transition when first booting up.
- FPS counter visibility not updating on first toggle.
- Warnings in the debug log.
