require 'date'
# User interface class for Cinema
class ConsoleUserInterface
  def list(things, seperate = false)
    things.each.with_index do |thing, index|
      puts "#{index + 1}. #{thing}"
      puts '==================================' if seperate
    end
  end

  def receive_input
    gets.chomp
  end

  def receive_yes_no
    answer = receive_input.downcase
    return true if answer == 'y'
    return false if answer == 'n'
    send_message('Please enter Y(yes) or N(no):')
    receive_yes_no
  end

  def receive_multi_input
    multi_input = []
    until (a = receive_input) == ''
      multi_input.push(a)
    end
    multi_input.uniq
  end

  def receive_integer_input(*range)
    return Integer(receive_input)
  rescue ArgumentError
    send_message('Please enter a number:' + range.to_s)
    receive_integer_input
  end

  def receive_date_input(format = '%Y-%m-%d')
    date = receive_input
    return valid_date?(date, format) if valid_date?(date, format)
    send_message('Please enter date in YYYY-MM-DD format:')
    receive_date_input(format)
  end

  def receive_time_input
    hour = receive_integer_input(0..23) until (0..23).cover?(hour)
    minute = receive_integer_input(0..59) until (0..59).cover?(minute)
    { hour: hour, minute: minute }
  end

  def receive_list_item(array)
    list(array)
    return retreive_item(array)
  rescue ArgumentError => error
    send_message(error.message)
    receive_list_item(array)
  end

  def send_message(message)
    puts message
  end

  private

  def retreive_item(array)
    input = receive_integer_input - 1
    raise ArgumentError, 'Number is not in range' unless
      (0..array.count).cover?(input)
    array.take(input + 1).last
  end

  def valid_date?(str, format = '%Y-%m-%d')
    Date.strptime(str, format).to_time + Time.now.utc_offset
  rescue
    false
  end
end
