require 'rspec/expectations'

# custom rspec matchers for Cinema
module RepertoireMatchers
  extend RSpec::Matchers::DSL
  matcher :have_movie do |movie|
    match do |repertoire|
      repertoire.movies.include? movie
    end

    failure_message do |repertoire|
      "Expected repertoire #{repertoire} to have movie:\n#{movie}"
    end

    failure_message_when_negated do |repertoire|
      "Expected repertoire #{repertoire} not to have movie:\n#{movie}"
    end
  end

  matcher :have_movie_screening do |movie_screening|
    match do |repertoire|
      repertoire.movie_screenings.include? movie_screening
    end

    failure_message do |repertoire|
      %(Expected repertoire #{repertoire} to have movie screening:\n
      #{movie_screening})
    end

    failure_message_when_negated do |repertoire|
      %(Expected repertoire #{repertoire} not to have movie screening:\n
      #{movie_screening})
    end
  end
end
