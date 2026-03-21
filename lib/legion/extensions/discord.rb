# frozen_string_literal: true

require 'legion/extensions/discord/version'
require 'legion/extensions/discord/helpers/client'
require 'legion/extensions/discord/runners/messages'
require 'legion/extensions/discord/runners/channels'
require 'legion/extensions/discord/runners/webhooks'
require 'legion/extensions/discord/client'

module Legion
  module Extensions
    module Discord
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
