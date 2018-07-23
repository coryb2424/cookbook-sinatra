class Recipe
  attr_reader :name, :description, :prep_time
  def initialize(attr)
    @name = attr[:name].capitalize
    @description = attr[:description].capitalize.gsub('"', '')
    @prep_time = attr[:prep_time]
    @done = attr[:done] || false
  end

  def done?
    @done
  end

  def done!
    @done = true
  end
end
