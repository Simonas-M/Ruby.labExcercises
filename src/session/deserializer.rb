# class for Cinema objects deserialization
class Deserializer
  def self.deserialize(serial, object_class)
    return if serial[object_class].nil?
    serial[object_class].each do |key, value|
      serial[object_class][key] = Object.const_get(object_class)
                                        .hash_create(serial, value)
    end
  end

  def self.deserialize_sequence(serial, sequence)
    sequence.each do |object_class|
      serial[object_class] = deserialize(serial, object_class)
    end
  end
end
