# frozen_string_literal: true

class OctokitGitClient
  def initialize(access_token = nil)
    @client = Octokit::Client.new(
      access_token: access_token
    )
  end

  def commits(repository, limit: 10, after: nil)
    octokit_commits = fetch_commits(repository)
    newer_commits = octokit_commits.take_while do |c|
      next true if after.nil?

      c.id != after
    end
    newer_commits.take(limit).each_with_object([]) do |commit, result|
      result << to_commit(commit)
    end
  rescue Octokit::NotFound
    nil
  end

  private

  def to_commit(github_commit)
    Commit.new(
      id: github_commit[:sha],
      message: github_commit[:commit][:message]
    )
  end

  def fetch_commits(repository)
    repository_name = repository.sub('github.com/', '')
    repository = client.repository repository_name
    repository.rels[:commits].get.data
  end

  attr_reader :client
end
