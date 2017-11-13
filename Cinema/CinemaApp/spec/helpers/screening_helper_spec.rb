require 'rails_helper'

RSpec.describe ScreeningHelper, type: :helper do
  before :each do
    @screening = double('screening')
    @start_time = Time.new(2017, 10, 19, 16)
    @duration = 8800
  end
  it 'should extract existing screening time frame' do
    allow(@screening).to receive(:time).and_return @start_time
    allow(@screening).to receive_message_chain(:movie, duration: @duration)

    range = ScreeningHelper.extract_exsisting_time_range(@screening)

    expect(range).to be_a_kind_of(Range)
    expect(range.first).to eq @start_time
    expect(range.end).to eq @start_time + @duration
  end

  it 'should extract new screening time frame' do
    movie = double('movie')
    allow(@screening).to receive(:[])
      .with(:time)
      .and_return @start_time
    allow(@screening).to receive(:[])
      .with(:movie_id)
      .and_return 'some_value'

    allow(movie).to receive(:duration).and_return @duration
    allow(Movie).to receive(:find).and_return movie

    range = ScreeningHelper.extract_new_time_range(@screening)

    expect(range).to be_a_kind_of(Range)
    expect(range.first).to eq @start_time
    expect(range.end).to eq @start_time + @duration
  end

  it 'should check if screenings overlap' do
    first_range = Time.new(2017, 11, 15, 16)..Time.new(2017, 11, 15, 17, 30)
    second_range = Time.new(2017, 11, 15, 16)..Time.new(2017, 11, 15, 17, 30)
    allow(ScreeningHelper).to receive(:extract_exsisting_time_range)
      .and_return first_range
    allow(ScreeningHelper).to receive(:extract_new_time_range)
      .and_return second_range

    existing = double('existing')
    new_scr = double('new_scr')
    allow(existing).to receive_message_chain(:screen, id: 1)
    allow(new_scr).to receive(:[]).with(:screen_id).and_return 1
    allow(DatetimeHelper).to receive(:overlaps?).and_call_original
    ScreeningHelper.overlaps?(existing, new_scr)
    expect(DatetimeHelper).to receive(:overlaps?)
  end
end
