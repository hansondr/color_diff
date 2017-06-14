require 'rspec'
require 'color_diff'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.order = :random
  config.profile_examples = 10
  Kernel.srand config.seed

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end
