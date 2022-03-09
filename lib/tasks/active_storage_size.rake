include ActionView::Helpers::NumberHelper

namespace :active_storage_size do
  task count: :environment do
    puts "All files size: #{number_to_human_size(ActiveStorage::Blob.sum(:byte_size))}"
  end
end
