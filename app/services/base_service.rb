class BaseService
  def to_boolean(str)
    ActiveRecord::Type::Boolean.new.deserialize(str)
  end
end