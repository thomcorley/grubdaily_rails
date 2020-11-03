class RecipeTouchWorker
  include Sidekiq::Worker

  def perform
    10.times do
      Recipe.all.each{ |r| r.touch }
    end
  end
end
