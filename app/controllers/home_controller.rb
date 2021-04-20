class HomeController < ApplicationController
  def index
    entries = Entry.where(published: true)
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
    @latest_entry = Entry.where(published: true).order("published_at DESC").first

    if @latest_entry.nil?
      redirect_to root_url
    else
      redirect_to @latest_entry.permalink
    end
  end
end
