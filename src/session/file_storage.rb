# class used for session storage into files
class FileStorage
  def initialize(file_path)
    @file_path = file_path
    open
  end

  def write(string)
    clear_file
    @storage.puts(string.to_s)
  end

  def read_all
    @storage.rewind
    @storage.read
  end

  def open
    @storage = File.open(@file_path, 'r+')
  rescue Errno::ENOENT
    @storage = File.new(@file_path, 'w+')
  end

  def clear_file
    self.end
    @storage = File.open(@file_path, 'w')
  end

  def end
    @storage.close
  end
end
