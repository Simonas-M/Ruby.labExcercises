# Serialization for Cinema objects
class Serializer
  def self.serialize(object)
    raise 'object cannot be serialized' unless
      object.class.method_defined? :to_json
    object.to_hash
  end

  def self.serialize_all(objects)
    serialized = {}
    objects.each do |item|
      serialized[item.class.to_s] = {} unless serialized[item.class.to_s]
      serialized[item.class.to_s][item.object_id.to_s] = serialize(item)
    end
    serialized.to_json
  end
end
