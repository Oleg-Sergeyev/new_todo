# frozen_string_literal: true

namespace :resque do
  desc 'Импорт и/или удаление пользователей'
  task users_manager: :environment do
    ManageUsersJob.perform_now
  end
end
