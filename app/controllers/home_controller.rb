class HomeController < ApplicationController
  def index
    entries = (Recipe.where(published: true) + BlogPost.where(published: true))
    entries_for_display = entries.sort_by{ |entry| entry.created_at }.last(7)

    @latest_entry = entries_for_display[6]
    @latest_entry_excerpt = MarkdownConverter.convert(@latest_entry.excerpt)
    @next_two_latest_entries = entries_for_display[4..5].reverse
    @recent_entries = entries_for_display[0..3].reverse
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
      Recipe.where(published: true).order("created_at DESC").first,
      BlogPost.where(published: true).order("created_at DESC").first
    ]

    @latest_entry = entries.sort_by{ |entry| entry.created_at }.last

    redirect_to @latest_entry.permalink
  end
end
