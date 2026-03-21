# frozen_string_literal: true

module Legion
  module Extensions
    module Discord
      module Runners
        module Messages
          def send_message(channel_id:, content:, tts: false, embeds: nil, **)
            body = { content: content, tts: tts }
            body[:embeds] = embeds if embeds
            resp = connection(**).post("/channels/#{channel_id}/messages", body)
            { message: resp.body }
          end

          def edit_message(channel_id:, message_id:, content: nil, embeds: nil, **)
            body = {}
            body[:content] = content if content
            body[:embeds]  = embeds if embeds
            resp = connection(**).patch("/channels/#{channel_id}/messages/#{message_id}", body)
            { message: resp.body }
          end

          def delete_message(channel_id:, message_id:, **)
            resp = connection(**).delete("/channels/#{channel_id}/messages/#{message_id}")
            { deleted: resp.status == 204, message_id: message_id }
          end

          def get_messages(channel_id:, limit: 50, before: nil, after: nil, around: nil, **)
            params = { limit: limit }
            params[:before] = before if before
            params[:after]  = after if after
            params[:around] = around if around
            resp = connection(**).get("/channels/#{channel_id}/messages", params)
            { messages: resp.body }
          end
        end
      end
    end
  end
end
