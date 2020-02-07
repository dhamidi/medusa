# frozen_string_literal: true

RSpec.shared_context 'test_settings' do
  test_commits = [
    Commit.new(id: 'cca6e8ff8d30ca8048165fe8cd545567f91c3edb', message: 'Add Hash#each_value and Hash#each_key cop (#7677)

'),
    Commit.new(id: '3e17f74113911683e54268fa5a02d41f0665f836', message: 'Merge pull request #7692 from marcandre/parent_doc

NodePattern: document ^ [doc]'),
    Commit.new(id: 'ed25f9b7f190fd8563a337f1caf29c2d4be3c929', message: 'NodePattern: document ^ [doc]
'),
    Commit.new(id: 'a6f8550c719daf146c80dcb6901d8805482a2479', message: 'Improve wording in README (#7690)


'),
    Commit.new(id: '2480085b58e28f06668a57765e0ea93e5acb58c0', message: 'Show pending status in cop status of manual

Follow up of #5979.

This PR shows pending status in cop status of manual.
The pending status is not enabled status and may lead to misreading.
'),
    Commit.new(id: '0a30ee0ebd028ae4c5e563ceacab4fb0b16ed9cc', message: 'Fix the changelog
'),
    Commit.new(id: 'd689522354c678b81b10bdff4c4d4835bcb4f51f', message: "Add `AllowGemfileRubyComment` option to `Layout/LeadingCommentSpace` (#7577)

This PR remove the offense for comments that starts with `#ruby` as this style is
a valid syntax to write Ruby versions in Gemfile that can be used with bundler, RVM, and others.

Example:

```ruby
  # Specific version (comment) will be used by RVM
  #ruby=2.7.0
  #ruby-gemset=myproject
  ruby '~> 2.7.0'
```

Co-authored-by: Bozhidar Batsov <bozhidar.batsov@gmail.com>
"),
    Commit.new(id: 'ac6514009940e7fd8cd72b7a5cf7e02b434eaa96', message: 'Add line length autocorrect for blocks
'),
    Commit.new(id: '8dd289484abbb4f2f9da72c0d50b24ba00d91614', message: 'Add cops to enforce use of `transform_keys` and `transform_values` (#7663)


'),
    Commit.new(id: '28eb77720e4b92f173ab3ef4888a40f3aee05c5b', message: '[Fix #7619] Support autocorrect of legacy names for `Migration/DepartmentName`

Fixes #7619.

This PR supports autocorrect of legacy cop names for
`Migration/DepartmentName`.

Auto-correction for legacy cop names complements legacy department names.
Migration to new cop names are expected to be modified using Gry gem.
https://github.com/pocke/gry
'),
    Commit.new(id: 'ba593507f5f9d0444750bad6eb1114b2ba03de77', message: 'Update Copyright year to 2020

This PR updates Copyright year to 2020.
'),
    Commit.new(id: 'd67ba354f3a03e9f7097b4b28af0bb9699a368c7', message: 'Merge pull request #7652 from masarakki/allow-paremeter-pp

allow paremeter name `pp` for `pretty_print`'),
    Commit.new(id: '8fd36f0df74fe27221c5d4c9bf726c7e41cb9897', message: '[Fix #7675] Fix a false negative for `Layout/SpaceBeforeFirstArg`

Fixes #7675.

This PR fixes a false negative for `Layout/SpaceBeforeFirstArg`
when a vertical argument positions are aligned.
'),
    Commit.new(id: 'c74c0602a7212cd7479e8326055cba39f2b4d8c2', message: 'allow-parameter-pp
'),
    Commit.new(id: 'b08092bf6150f18b450c965a5084022254600969', message: 'Merge pull request #7681 from picandocodigo/master

Updates docs to be more explicit when using formatters'),
    Commit.new(id: 'bd94c402ee799299ac6b17af97dc84285ec46af5', message: 'Updates docs to be more explicit about how to use formatters
'),
    Commit.new(id: '31fe1a58d196f474991daf64d97fe64e9836bb71', message: 'Merge pull request #7676 from drewcimino/docs-update-targetruby-preference

Update documentation to reflect current precedence in TargetRuby'),
    Commit.new(id: '45d738a9712944e4e145e380f56ffe5a4b97e044', message: 'Update docs to reflect current precedence in TargetRuby
'),
    Commit.new(id: '58ab70fe2203f77ee04a48e68fea15256db0cf21', message: 'Merge pull request #7679 from koic/workaround_for_cc_test_reporter_with_simplecov

Workaround for cc-test-reporter with SimpleCov 0.18'),
    Commit.new(id: '7f9fd4a9eb59b73218111e447e03ef61ec75a01a', message: 'Workaround for cc-test-reporter with SimpleCov 0.18

This PR fixes the following build error when using
cc-test-reporter with SimpleCov 0.18.

```console
$ #!/bin/bash -eo pipefail
./tmp/cc-test-reporter before-build
COVERAGE=true bundle exec rake spec
./tmp/cc-test-reporter format-coverage --output
tmp/codeclimate.$CIRCLE_JOB.json
Starting test-queue master (/tmp/test_queue_228_47138309905180.sock)

==> Summary (2 workers in 36.1115s)

    [ 1]                         8753 examples, 0 failures, 9 pending
    254 suites in 36.1034s      (pid 160 exit 0 )
    [ 2]                         6772 examples, 0 failures, 2 pending
    239 suites in 36.1054s      (pid 161 exit 0 )

Coverage report generated for RSpec, rspec-1, rspec-2, rspec-fork-163,
rspec-fork-164, rspec-fork-165 to /home/circleci/project/coverage. 21266
/ 21459 LOC (99.1%) covered.
Error: json: cannot unmarshal object into Go struct field input.coverage
of type []formatters.NullInt
Usage:
  cc-test-reporter format-coverage [coverage file] [flags]

Flags:
      --add-prefix string   add this prefix to file paths
  -t, --input-type string   type of input source to use [clover,
cobertura, coverage.py, excoveralls, gcov, gocov, jacoco, lcov,
simplecov, xccov]
  -o, --output string       output path (default "coverage/codeclimate.json")
  -p, --prefix string       the root directory where the
    coverage analysis was performed (default "/home/circleci/project")

Global Flags:
  -d, --debug   run in debug mode

Exited with code exit status 255
```

https://circleci.com/gh/rubocop-hq/rubocop/83619

This patch is a workaround until the following issue will be resolved.
https://github.com/codeclimate/test-reporter/issues/418
')

  ]
  git_client = TestGitClient.new('github.com/rubocop-hq/rubocop' => test_commits)
  before(:context) do
    @settings = Settings.new(
      git_client: git_client
    )
  end
  attr_reader :settings
end
