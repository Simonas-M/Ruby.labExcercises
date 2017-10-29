# class for Cinema objects deserialization
class Deserializer
  def self.deserialize(serial, object_class)
    object_branch = serial[object_class]
    return unless object_branch
    object_branch.each do |key, value|
      object_branch[key] = Object.const_get(object_class)
                                 .hash_create(serial, value)
    end
  end

  def self.deserialize_sequence(serial, sequence)
    sequence.each do |object_class|
      serial[object_class] = deserialize(serial, object_class)
    end
    serial
  end
end
