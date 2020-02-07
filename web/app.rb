# frozen_string_literal: true

require 'sinatra'
require 'medusa'

set :erb, layout: :'layout.html'
set :medusa, Settings.new(
  git_client: OctokitGitClient.new,
  key_value_store: PstoreKeyValueStore.new('production.pstore')
)

helpers do
  def medusa
    settings.medusa
  end
end

get '/' do
  subscriptions = DashboardQuery.new(medusa).call
  erb :'index.html', locals: {
    subscriptions: subscriptions
  }
end

post '/scan' do
  watched = WatchedRepositoriesQuery.new(medusa).call
  halt unless watched.map(&:repository).include?(params[:repository])
  ScanRepositoryAction.async(medusa, params[:repository])
  redirect '/'
end

post '/watch' do
  WatchRepositoryAction.new(medusa).call(
    params[:repository],
    params[:pattern]
  )
  redirect '/'
end
