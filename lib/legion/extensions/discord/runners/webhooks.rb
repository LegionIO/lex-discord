# frozen_string_literal: true

module Legion
  module Extensions
    module Discord
      module Runners
        module Webhooks
          def execute_webhook(webhook_id:, webhook_token:, content: nil, username: nil, avatar_url: nil, embeds: nil, **)
            body = {}
            body[:content]    = content if content
            body[:username]   = username if username
            body[:avatar_url] = avatar_url if avatar_url
            body[:embeds]     = embeds if embeds
            resp = connection(**).post("/webhooks/#{webhook_id}/#{webhook_token}", body)
            { executed: [204, 200].include?(resp.status), response: resp.body }
          end

          def edit_webhook_message(webhook_id:, webhook_token:, message_id:, content: nil, embeds: nil, **)
            body = {}
            body[:content] = content if content
            body[:embeds]  = embeds if embeds
            resp = connection(**).patch("/webhooks/#{webhook_id}/#{webhook_token}/messages/#{message_id}", body)
            { message: resp.body }
          end
        end
      end
    end
  end
end
