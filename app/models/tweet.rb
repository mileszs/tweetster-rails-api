class Tweet < ApplicationRecord
  def as_json(options = {})
    default_json = super(options)
    default_json[:display_name] = display_name
    default_json
  end

  def display_name
    "Saiyan News Bot"
  end
end
