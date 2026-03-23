# Changelog

## [0.1.2] - 2026-03-22

### Changed
- Add legion-logging, legion-settings, legion-cache, legion-crypt, legion-data, legion-json, and legion-transport as runtime dependencies
- Update spec_helper with real sub-gem helper stubs for Helpers::Lex

## [0.1.0] - 2026-03-21

### Added
- Initial release
- `Helpers::Client` — Faraday connection builder targeting Discord API v10 with Bot token auth
- `Runners::Messages` — send_message, edit_message, delete_message, get_messages
- `Runners::Channels` — list_guild_channels, get_channel, create_channel
- `Runners::Webhooks` — execute_webhook, edit_webhook_message
- Standalone `Client` class for use outside the Legion framework
