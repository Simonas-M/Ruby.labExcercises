# Serialization for Cinema objects
class Serializer
  def self.serialize(object)
    raise 'object cannot be serialized' unless
      object.class.method_defined? :to_hash
    object.to_hash
  end

  def self.serialize_all(objects)
    serialized = {}
    objects.each do |item|
      object_branch = retreive_branch(serialized, item.class.to_s)
      object_branch[item.object_id.to_s] = serialize(item)
    end
    serialized.to_json
  end

  def self.create_branch(serial, object_class)
    serial[object_class] = {} unless serial[object_class]
  end

  def self.retreive_branch(serial, object_class)
    create_branch(serial, object_class)
    serial[object_class]
  end
end
