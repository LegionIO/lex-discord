# lex-discord

LegionIO extension for Discord integration via the Discord REST API v10.

## Installation

Add to your Gemfile:

```ruby
gem 'lex-discord'
```

## Standalone Usage

```ruby
require 'legion/extensions/discord'

client = Legion::Extensions::Discord::Client.new(token: 'your-bot-token')

# Messages
client.send_message(channel_id: '123456789', content: 'Hello from Legion!')
client.get_messages(channel_id: '123456789', limit: 10)
client.edit_message(channel_id: '123456789', message_id: '987654321', content: 'Updated message')
client.delete_message(channel_id: '123456789', message_id: '987654321')

# Channels
client.list_guild_channels(guild_id: '111222333')
client.get_channel(channel_id: '123456789')
client.create_channel(guild_id: '111222333', name: 'announcements')

# Webhooks
client.execute_webhook(webhook_id: '444555666', webhook_token: 'webhook-token', content: 'Deployed!')
client.edit_webhook_message(webhook_id: '444555666', webhook_token: 'webhook-token', message_id: '777888999', content: 'Updated')
```

## Authentication

Discord bot authentication uses a Bot token in the `Authorization` header. Create a bot and obtain its token at: https://discord.com/developers/applications

## License

MIT
