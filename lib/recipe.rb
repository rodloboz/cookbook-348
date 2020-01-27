class Recipe
  attr_reader :name, :description, :duration, :difficulty

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @duration = attributes[:duration]
    @difficulty = attributes[:difficulty]
    # If attributes doesn't include done, set
    # default to false
    # @done    =      nil   || false
    @done = attributes[:done] || false
  end

  # getter
  # def name
  #   @name
  # end

  # # setter
  # def name=(name)
  #   @name = name
  # end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end

  def to_csv_row
    # user the readers / getters
    [name, description, duration, difficulty, done?]
  end

  def to_s
    "[#{done? ? 'x' : ' '}] Name: #{name} | Description: #{description}"
  end
end
