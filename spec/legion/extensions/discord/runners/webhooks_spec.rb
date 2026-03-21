# frozen_string_literal: true

RSpec.describe Legion::Extensions::Discord::Runners::Webhooks do
  let(:client) { Legion::Extensions::Discord::Client.new(token: 'test-bot-token') }

  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:test_connection) do
    Faraday.new(url: 'https://discord.com/api/v10') do |conn|
      conn.request :json
      conn.response :json, content_type: /\bjson$/
      conn.adapter :test, stubs
    end
  end

  before { allow(client).to receive(:connection).and_return(test_connection) }

  describe '#execute_webhook' do
    it 'executes a webhook and returns executed true on 204' do
      stubs.post('/webhooks/300/wh-secret-token') do
        [204, {}, nil]
      end
      result = client.execute_webhook(webhook_id: '300', webhook_token: 'wh-secret-token', content: 'Deployed!')
      expect(result[:executed]).to be true
    end

    it 'executes a webhook and returns body on 200' do
      stubs.post('/webhooks/300/wh-secret-token') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => '777', 'content' => 'Deployed!' }]
      end
      result = client.execute_webhook(webhook_id: '300', webhook_token: 'wh-secret-token', content: 'Deployed!')
      expect(result[:executed]).to be true
      expect(result[:response]['id']).to eq('777')
    end
  end

  describe '#edit_webhook_message' do
    it 'edits a webhook message and returns it' do
      stubs.patch('/webhooks/300/wh-secret-token/messages/777') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => '777', 'content' => 'Updated deploy message' }]
      end
      result = client.edit_webhook_message(
        webhook_id:    '300',
        webhook_token: 'wh-secret-token',
        message_id:    '777',
        content:       'Updated deploy message'
      )
      expect(result[:message]['content']).to eq('Updated deploy message')
    end
  end
end
