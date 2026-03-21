# frozen_string_literal: true

RSpec.describe Legion::Extensions::Discord::Runners::Messages do
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

  describe '#send_message' do
    it 'sends a message and returns it' do
      stubs.post('/channels/123/messages') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => '999', 'content' => 'Hello!' }]
      end
      result = client.send_message(channel_id: '123', content: 'Hello!')
      expect(result[:message]['id']).to eq('999')
      expect(result[:message]['content']).to eq('Hello!')
    end
  end

  describe '#edit_message' do
    it 'edits a message and returns it' do
      stubs.patch('/channels/123/messages/999') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => '999', 'content' => 'Updated!' }]
      end
      result = client.edit_message(channel_id: '123', message_id: '999', content: 'Updated!')
      expect(result[:message]['content']).to eq('Updated!')
    end
  end

  describe '#delete_message' do
    it 'returns deleted true on 204' do
      stubs.delete('/channels/123/messages/999') do
        [204, {}, nil]
      end
      result = client.delete_message(channel_id: '123', message_id: '999')
      expect(result[:deleted]).to be true
      expect(result[:message_id]).to eq('999')
    end
  end

  describe '#get_messages' do
    it 'returns an array of messages' do
      stubs.get('/channels/123/messages') do
        [200, { 'Content-Type' => 'application/json' },
         [{ 'id' => '1', 'content' => 'Hi' }, { 'id' => '2', 'content' => 'Hey' }]]
      end
      result = client.get_messages(channel_id: '123')
      expect(result[:messages]).to be_an(Array)
      expect(result[:messages].first['id']).to eq('1')
    end
  end
end
