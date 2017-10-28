# class used for session storage into files
class FileStorage
  def initialize(file_path)
    open(file_path)
  end

  def write(string)
    @storage.truncate(0)
    @storage.puts(string.to_s)
  end

  def read_all
    @storage.rewind
    @storage.read
  end

  def open(file_path)
    @storage = File.open(file_path, 'r+')
  rescue Errno::ENOENT
    @storage = File.new(file_path, 'r+')
  end

  def end
    @storage.close
  end
end
