require 'date'
# User interface class for Cinema
class ConsoleUserInterface
  def list(things)
    things.each.with_index { |thing, index| puts "#{index + 1}. #{thing}" }
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

  def receive_integer_input
    return Integer(receive_input)
  rescue ArgumentError
    send_message('Please enter a number')
    receive_integer_input
  end

  def receive_date_input(format = '%Y-%m-%d')
    date = receive_input
    return valid_date?(date, format) if valid_date?(date, format)
    send_message('Please enter date in YYYY-MM-DD format:')
    receive_date_input(format)
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
      Range.new(0, array.length).include?(input)
    array[input]
  end

  def valid_date?(str, format = '%Y-%m-%d')
    Date.strptime(str, format)
  rescue
    false
  end
end
