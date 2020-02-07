# frozen_string_literal: true

class OctokitGitClient
  def initialize(access_token = nil)
    @client = Octokit::Client.new(
      access_token: access_token
    )
  end

  def commits(repository, limit: 10, after: nil)
    octokit_commits = fetch_commits(repository, after: after)
    octokit_commits.take(limit).each_with_object([]) do |commit, result|
      result << Commit.new(
        id: commit[:sha],
        message: commit[:commit][:message]
      )
    end
  rescue Octokit::NotFound
    nil
  end

  private

  def fetch_commits(repository, after:)
    repository_name = repository.sub('github.com/', '')
    repository = client.repository repository_name
    params = {}
    params[:after] = after if after
    repository.rels[:commits].get(query: params).data
  end

  attr_reader :client
end
