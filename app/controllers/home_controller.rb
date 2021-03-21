class HomeController < ApplicationController
  def index
    entries = (Recipe.where(published: true) + BlogPost.where(published: true))
    @entries_for_display = entries.sort_by{ |entry| entry.created_at }.last(17).reverse
    @entries_for_carousel = @entries_for_display.first(5)
    @recent_entries = @entries_for_display.last(12)
  end

  def about
  end

  def recipe_index
    @recipes = Recipe.where(published: true).order(title: :asc)
  end

  def photos
    @recipes = Recipe.where(published: true).last(24).reverse
  end

  def latest_entry
    entries = [
      Recipe.where(published: true).order("published_at DESC").first,
      BlogPost.where(published: true).order("published_at DESC").first
    ]

    if entries.empty?
      redirect_to root_url
    else
      @latest_entry = entries.sort_by{ |entry| entry.published_at }.last

      redirect_to @latest_entry.permalink
    end
  end
end
