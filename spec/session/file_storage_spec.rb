require_relative '../../src/session/file_storage.rb'

RSpec.describe 'FileStorage' do
  before(:each) do
    @storage = {}
  end

  after(:each) do
    @storage.end
    File.delete('./spec/data/test_file.json')
  end

  it 'should create a file if it does not exist' do
    expect(File.exist?('./spec/data/test_file.json')).to be false
    @storage = FileStorage.new('./spec/data/test_file.json')
    expect(File.exist?('./spec/data/test_file.json')).to be true
  end
end
