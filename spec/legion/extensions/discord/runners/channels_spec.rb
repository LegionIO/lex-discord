# frozen_string_literal: true

RSpec.describe Legion::Extensions::Discord::Runners::Channels do
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

  describe '#list_guild_channels' do
    it 'returns an array of channels' do
      stubs.get('/guilds/456/channels') do
        [200, { 'Content-Type' => 'application/json' },
         [{ 'id' => '100', 'name' => 'general' }, { 'id' => '101', 'name' => 'random' }]]
      end
      result = client.list_guild_channels(guild_id: '456')
      expect(result[:channels]).to be_an(Array)
      expect(result[:channels].first['name']).to eq('general')
    end
  end

  describe '#get_channel' do
    it 'returns a single channel' do
      stubs.get('/channels/100') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => '100', 'name' => 'general' }]
      end
      result = client.get_channel(channel_id: '100')
      expect(result[:channel]['id']).to eq('100')
      expect(result[:channel]['name']).to eq('general')
    end
  end

  describe '#create_channel' do
    it 'creates a channel and returns it' do
      stubs.post('/guilds/456/channels') do
        [201, { 'Content-Type' => 'application/json' },
         { 'id' => '200', 'name' => 'announcements', 'type' => 0 }]
      end
      result = client.create_channel(guild_id: '456', name: 'announcements')
      expect(result[:channel]['id']).to eq('200')
      expect(result[:channel]['name']).to eq('announcements')
    end
  end
end
