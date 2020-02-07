# frozen_string_literal: true

class OctokitGitClient
  def initialize(access_token = nil)
    @client = Octokit::Client.new(
      access_token: access_token
    )
  end

  def commits(repository, limit: 10, after: nil)
    return nil unless repository.start_with?('github.com/')

    repository_name = repository.sub('github.com/', '')
    repository = client.repository repository_name
    params = {}
    params[:after] = after if after
    repository.rels[:commits].get(query: params).data.take(limit).each_with_object([]) do |commit, result|
      result << Commit.new(
        id: commit[:sha],
        message: commit[:commit][:message]
      )
    end
  rescue Octokit::NotFoundError => e
    nil
  end

  private

  attr_reader :client
end
