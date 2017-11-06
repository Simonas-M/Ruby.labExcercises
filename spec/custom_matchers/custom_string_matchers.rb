require 'rspec/expectations'

# Custom RSpec matchers for strings
module CustomStringMatchers
  extend RSpec::Matchers::DSL
  matcher :be_capitalized do
    match do |string|
      /([A-Z][\w-]*(\s+[A-Z][\w-]*)*)/.match(string)
    end

    failure_message do |string|
      %(Expected string #{string} to have every word capitalized:\n
      #{string})
    end

    failure_message_when_negated do |string|
      %(Expected string #{string} not to have every word capitalized:\n
      #{string})
    end
  end
end
