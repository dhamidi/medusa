# frozen_string_literal: true

require 'active_model'
require 'digest/sha1'
require 'octokit'
require 'pstore'
require 'yaml'
require 'zeitwerk'

module Medusa
  @loader = Zeitwerk::Loader.for_gem.tap do |loader|
    loader.push_dir('lib/medusa/actions')
    loader.push_dir('lib/medusa/models')
    loader.push_dir('lib/medusa/queries')
    loader.push_dir('lib/medusa/external')
    loader.push_dir('lib/medusa/types')
    loader.eager_load
    loader.setup
  end

  ActiveModel::Type.register(:sha1, Sha1Type)
  ActiveModel::Type.register(:repository_id, RepositoryIdType)
end
