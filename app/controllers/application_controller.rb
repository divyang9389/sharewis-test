class ApplicationController < ActionController::API
  private

  def default_locale_code
    'en'
  end

  def to_boolean(str)
    ActiveRecord::Type::Boolean.new.deserialize(str)
  end
end
