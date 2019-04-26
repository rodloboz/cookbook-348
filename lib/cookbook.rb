require 'byebug'
require 'csv'

require_relative 'recipe'

class Cookbook
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @recipes = []
    load_csv
  end

  def all # lists all recipes
    @recipes
  end

  def add_recipe(recipe) #receives an instance of recipe
    @recipes << recipe
    write_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    write_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_filepath) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def write_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << recipe.to_csv_row
      end
    end
  end
end
