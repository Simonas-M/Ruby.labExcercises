require 'rspec/expectations'

# Custom RSpec matchers for strings
module CustomStringMatchers
  extend RSpec::Matchers::DSL
  matcher :be_capitalized do
    match do |string|
      matches = []
      matches.concat(/^\w/.match(string).to_a)
      matches.concat(/ \w/.match(string).to_a)
      matches.all? { |letter| letter == letter.upcase }
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
