class RecipeTouchWorker
  include Sidekiq::Worker

  def perform
    250.times do
      Recipe.all.each{ |r| r.touch }
    end
  end
end
