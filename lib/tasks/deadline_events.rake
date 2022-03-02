namespace :deadline_events do
  desc 'Пометка выполненными устаревших deadline-заданий'
  task cleanup: :environment do
    DeadlineEventsCleanupJob.perform_now(1.week.ago)
  end
end
