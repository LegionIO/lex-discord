# Changelog

## [0.1.0] - 2026-03-21

### Added
- Initial release
- `Helpers::Client` — Faraday connection builder targeting Discord API v10 with Bot token auth
- `Runners::Messages` — send_message, edit_message, delete_message, get_messages
- `Runners::Channels` — list_guild_channels, get_channel, create_channel
- `Runners::Webhooks` — execute_webhook, edit_webhook_message
- Standalone `Client` class for use outside the Legion framework
