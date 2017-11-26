# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScreeningHelper, type: :helper do
  it 'should extract existing screening time frame' do
    screening = double('screening')
    start_time = Time.new(2017, 10, 19, 16)
    duration = 8800
    allow(screening).to receive(:time).and_return start_time
    allow(screening).to receive_message_chain(:movie, duration: duration)

    range = ScreeningHelper.extract_exsisting_time_range(screening)

    expect(range).to be_a_kind_of(Range)
    expect(range.first).to eq start_time
    expect(range.end).to eq start_time + duration
  end

  it 'should extract new screening time frame' do
    screening = double('screening')
    allow(screening).to receive(:time).and_return Time.now

    range = ScreeningHelper.extract_new_time_range(screening)
  end
end
