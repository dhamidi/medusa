# frozen_string_literal: true

require 'sinatra'
require 'medusa'

set :erb, layout: :'layout.html'
set :medusa, Settings.new(
  git_client: OctokitGitClient.new,
  key_value_store: PstoreKeyValueStore.new('production.pstore')
)

get '/' do
  subscriptions = WatchedRepositoriesQuery.new(settings.medusa).call
  erb :'index.html', locals: { subscriptions: subscriptions }
end
