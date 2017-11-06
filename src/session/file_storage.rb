# class used for session storage into files
class FileStorage
  def initialize(file_path)
    @file_path = file_path
    @storage = open('r+')
  end

  def write(string)
    clear_file
    @storage.print(string.to_s)
  end

  def read_all
    @storage.rewind
    @storage.read
  end

  def open(mode)
    File.open(@file_path, mode)
  rescue Errno::ENOENT
    open('w+')
  end

  def clear_file
    self.end
    @storage = open('w')
  end

  def end
    @storage.close
  end
end
