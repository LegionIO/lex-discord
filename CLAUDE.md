# lex-discord: Discord Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to Discord via the Discord REST API v10. Provides runners for channel management, message operations, and webhook execution.

**GitHub**: https://github.com/LegionIO/lex-discord
**License**: MIT
**Version**: 0.1.2

## Architecture

```
Legion::Extensions::Discord
├── Runners/
│   ├── Channels    # list_guild_channels, get_channel, create_channel, modify_channel, delete_channel
│   ├── Messages    # send_message, get_messages, get_message, edit_message, delete_message
│   └── Webhooks    # create_webhook, get_webhook, execute_webhook, edit_webhook_message, delete_webhook_message
├── Helpers/
│   └── Client      # Faraday connection (Discord API v10, Bot token auth)
└── Client          # Standalone client class (includes all runners)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/discord.rb` | Entry point, extension registration |
| `lib/legion/extensions/discord/runners/channels.rb` | Channel management runners |
| `lib/legion/extensions/discord/runners/messages.rb` | Message CRUD runners |
| `lib/legion/extensions/discord/runners/webhooks.rb` | Webhook runners |
| `lib/legion/extensions/discord/helpers/client.rb` | Faraday connection builder (Bot token auth) |
| `lib/legion/extensions/discord/client.rb` | Standalone Client class |

## Authentication

Discord Bot token authentication: `Authorization: Bot <token>` header. Create a bot and obtain the token at https://discord.com/developers/applications.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` (>= 2.0) | HTTP client for Discord REST API v10 |

## Development

13 specs total.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
