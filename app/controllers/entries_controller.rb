class EntriesController < ApplicationController
  def feed
    @entries = Entry.published.order(published_at: :desc)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
