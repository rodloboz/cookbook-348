require_relative 'cookbook'
require_relative 'view'
require_relative 'bbc_good_food_recipes_scrapper'

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
    index = @view.ask_for_index(range, :remove)
    # pass index to cookbook
    @cookbook.remove_recipe(index)
  end

  def import
    # - ask the user for the ingredient
    ingredient = @view.ask_for_ingredient
    # - search/scrape BBC Foods using this ingredient
    scrapper = BbcGoodFoodRecipesScrapperService.new(ingredient)
    recipes = scrapper.perform.recipes.take(5)
    # - display list of scrapped recipes
    @view.display_recipes(recipes)
    # - ask the user which recipe they want to import
    range = 0...recipes.length
    # ask for a index
    index = @view.ask_for_index(range, :import)
    # - add recipe to the cookbook
    recipe = recipes[index]
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # display recipes to user
    recipes = @cookbook.all
    @view.display_recipes(recipes)
    # ask user to pick an index
    range = 0...recipes.length
    index = @view.ask_for_index(range, "mark as done")
    # mark recipe as done
    recipe = @cookbook.find_recipe(index)
    recipe.mark_as_done!
    # save the changes
    @cookbook.save_all
  end
end






