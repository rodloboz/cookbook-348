
require 'open-uri'
require 'nokogiri'

# Example url: "https://www.bbcgoodfood.com/search/recipes?query=orange"


# scrapper = BbcGoodFoodRecipesScrapperService.new("apple")
# => [Recipe, Recipe]
class BbcGoodFoodRecipesScrapperService
  BASE_URL = "https://www.bbcgoodfood.com"

  attr_reader :recipes

  def initialize(ingredient)
    @url = BASE_URL + "/search/recipes?query=#{ingredient}"
    @recipes = [] # in the beginning there are no recipes
  end

  # Public interface: instance method
  def perform
    build_recipes # this returns array of recipes
    self # return the scrapper
  end

  private

  def elements
    @elements ||= page.search("#search-results article")
  end

  def build_recipes
    elements.each { |element| build_recipe(element) }
  end

  def build_recipe(element)
    # Recipe.new("carrot cake", "some description")
    name = element.search("h3").text.strip
    description = element.search(".field-type-text-with-summary").text
    duration = element.search(".teaser-item__info-item--total-time").text.strip
    difficulty = element.search(".teaser-item__info-item--skill-level").text.strip

    attributes = {
      name: name,
      description: description,
      duration: duration,
      difficulty: difficulty
    }
    @recipes << Recipe.new(attributes)
  end

  def page
    @page ||= page = Nokogiri::HTML.parse(doc)
  end

  def doc
    # Provided by open-uri, receives a String with a url
    @doc ||= open(@url).read # String with the HTML of the site
  end

end


# Create scrapper instance
# scrapper = BbcGoodFoodRecipesScrapperService.new("orange")
# byebug
# scrapper.perform # =>
# scrapper.recipes

