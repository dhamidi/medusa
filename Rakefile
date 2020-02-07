# frozen_string_literal: true

task 'spec:unit' do
  sh 'SPEC_CONTEXT=development bundle exec rspec'
end

task 'spec:integration' do
  sh 'SPEC_CONTEXT=production bundle exec rspec'
end

task 'spec' => ['spec:unit', 'spec:integration']

task default: 'spec'
