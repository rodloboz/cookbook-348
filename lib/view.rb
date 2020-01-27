class View
  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - " + recipe.to_s
    end
  end

  def ask_for(attribute)
    puts "What's the #{attribute} of the recipe?"
    print "> "
    gets.chomp
  end

  def ask_for_index(range, action)
    puts "What recipe do you want to #{action}?"
    print "> "
    index = gets.chomp

    # ensures user has picked a valid index
    until (index =~ /^\d+$/) && range.include?(index.to_i - 1)
      puts "Please pick a valid number."
      index = gets.chomp
    end

    index.to_i - 1
  end

  def ask_for_ingredient
    puts "What's the ingredient you're looking for?"
    print "> "
    gets.chomp
  end
end
