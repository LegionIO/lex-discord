# frozen_string_literal: true

module Legion
  module Extensions
    module Discord
      module Runners
        module Channels
          def list_guild_channels(guild_id:, **)
            resp = connection(**).get("/guilds/#{guild_id}/channels")
            { channels: resp.body }
          end

          def get_channel(channel_id:, **)
            resp = connection(**).get("/channels/#{channel_id}")
            { channel: resp.body }
          end

          def create_channel(guild_id:, name:, channel_type: 0, topic: nil, position: nil, **)
            body = { name: name, type: channel_type }
            body[:topic]    = topic if topic
            body[:position] = position if position
            resp = connection(**).post("/guilds/#{guild_id}/channels", body)
            { channel: resp.body }
          end
        end
      end
    end
  end
end
