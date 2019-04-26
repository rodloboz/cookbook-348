require_relative 'cookbook'
require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook # this is a Cookbook instance
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end

  def create
    # ask user for name
    name = @view.ask_for(:name)
    # ask user for description
    description = @view.ask_for(:description)
    # create a Recipe instance
    recipe = Recipe.new(name, description)
    # pass it to the cookbook (repo)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # self.list same as:
    recipes = list
    range = 0...recipes.length
    # ask for a index
    index = @view.ask_for_index(range)
    # pass index to cookbook
    @cookbook.remove_recipe(index)
  end
end
