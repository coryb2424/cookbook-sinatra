require 'csv'
class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @filepath = csv_file_path
    load_csv_recipes
  end

  def load_csv_recipes
    CSV.foreach(@filepath) do |row|
      @recipes << Recipe.new(
        name: row[0],
        description: row[1],
        prep_time: row[2],
        done: row[3] == 'true'
      )
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv_recipes
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv_recipes
  end

  def mark_as_done(index)
    @recipes[index].done!
  end

  def save_csv_recipes
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@filepath, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done?]
      end
    end
  end
end
