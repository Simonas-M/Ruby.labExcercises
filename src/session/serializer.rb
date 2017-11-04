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
    remap_object_ids(serialized).to_json
  end

  def self.create_branch(serial, object_class)
    serial[object_class] = {} unless serial[object_class]
  end

  def self.retreive_branch(serial, object_class)
    create_branch(serial, object_class)
    serial[object_class]
  end

  def self.remap_object_ids(serial_hash)
    counter = 0
    serialized_object_ids(serial_hash).each do |id|
      change_object_id(serial_hash, id, (counter += 1).to_s)
    end
    serial_hash
  end

  def self.serialized_object_ids(serialized_objects)
    ids = []
    serialized_objects.keys.each do |class_name|
      ids.concat(serialized_objects[class_name].keys)
    end
    ids
  end

  def self.change_object_id(serial, old_id, new_id)
    serial.keys.each do |class_name|
      change_class_objects_ids(serial[class_name], old_id, new_id)
    end
  end

  def self.change_class_objects_ids(class_objects, old_id, new_id)
    class_objects.keys.each do |id|
      change_value_id(class_objects[id], old_id, new_id)
      class_objects[new_id] = class_objects.delete(id) if id == old_id
    end
  end

  def self.change_value_id(serialized_object, old_id, new_id)
    serialized_object.each do |field, value|
      if value == old_id && field.to_s.end_with?('_id')
        serialized_object[field] = new_id
      end
    end
  end
end
