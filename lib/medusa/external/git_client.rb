# frozen_string_literal: true

class GitClient
  def initialize(root_directory)
    @root_directory = Pathname.new(root_directory)
  end

  def commits(repository, limit: 10)
    result = []
    git_log(repository, limit: limit) do |commit|
      result << commit
    end

    return nil if result.empty?

    result
  end

  private

  def git_log(repository, limit:)
    commits_yaml = IO.popen([env(repository), 'git', 'log', '-n', limit.to_i.to_s, '--format=' + commit_template, 'HEAD', { err: %i[child out] }]) do |git_log_cmd|
      git_log_cmd.read
    end
    return if $? != 0
    
    YAML.parse_stream(commits_yaml) do |document|
      as_hash = document.to_ruby
      if as_hash && as_hash['id'] && as_hash['message']
        yield Commit.new(id: as_hash['id'], message: as_hash['message'])
      end
    rescue Psych::SyntaxError => e
      # ignore this commit  
    end
  end

  def commit_template
    'id: %H%nmessage: |%n%w(0,2,2)%B%w(0)%n---%n'
  end

  def env(repository)
    { 'GIT_DIR' => root_directory.join(repository, '.git').to_s }
  end

  attr_reader :root_directory
end
