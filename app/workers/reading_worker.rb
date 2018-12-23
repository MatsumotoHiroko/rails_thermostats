class ReadingWorker
  include Sidekiq::Worker
  sidekiq_options queue: :reading
  def perform(params)
    Reading.create!(params)
  end
end
