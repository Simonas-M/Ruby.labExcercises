require 'json'

# Serialization for Cinema objects
class Serializer
  def self.serialize(object)
    raise 'object cannot be serialized' unless
      object.class.method_defined? :to_json
    object.to_json
  end

  def self.serialize_all(*objects)
    objects.map do |object|
      serialize(object)
    end
  end
end
