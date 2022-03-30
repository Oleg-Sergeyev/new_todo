# frozen_string_literal: true

# class ManageUsers
class ManageUsersJob < ApplicationJob
  queue_as :users

  def perform(ago = 1.week.ago)
    Rails.logger.info "0000000000000000000000000000 HERE 0000000000000000000000000000000000000"
    # send_data Services::UsersUpdateImportDelete.call,
    #           type: 'application/octet-stream',
    #           filename: 'tmp/users.xlsx'
    Services::UsersUpdateImportDelete.call('tmp/users.xlsx')
  end
end
