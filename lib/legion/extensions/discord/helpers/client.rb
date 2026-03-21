# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Discord
      module Helpers
        module Client
          def connection(token: nil, **_opts)
            Faraday.new(url: 'https://discord.com/api/v10') do |conn|
              conn.request :json
              conn.response :json, content_type: /\bjson$/
              conn.headers['Authorization'] = "Bot #{token}" if token
              conn.adapter Faraday.default_adapter
            end
          end
        end
      end
    end
  end
end
