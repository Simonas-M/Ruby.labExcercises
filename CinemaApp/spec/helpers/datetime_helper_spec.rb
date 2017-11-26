# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DatetimeHelper, type: :helper do
  it 'should validate date' do
    expect(DatetimeHelper.valid_date?('2000-01-01').utc)
      .to eq Time.utc(2000, 1, 1)
  end

  it 'should raise if date is not valid' do
    expect { DatetimeHelper.valid_date?('invalid') }
      .to raise_error(ArgumentError, 'invalid date')
  end

  it 'should add date and time' do
    date = Date.new(2012, 12, 12)
    time = { hour: 22, minute: 41 }
    expect(DatetimeHelper.add_date_and_time(date, time))
      .to eq Time.new(2012, 12, 12, 22, 41).utc
  end

  it 'should get current year' do
    expect(DatetimeHelper.current_year).to eq Time.now.utc.year
  end
end
