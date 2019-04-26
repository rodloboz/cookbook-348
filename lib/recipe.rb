class Recipe
  attr_reader :name, :description

  def initialize(name, description)
    @name = name
    @description = description
  end

  # getter
  # def name
  #   @name
  # end

  # # setter
  # def name=(name)
  #   @name = name
  # end

  def to_csv_row
    # user the readers / getters
    [name, description]
  end

  def to_s
    "Name: #{name} | Description: #{description}"
  end
end
