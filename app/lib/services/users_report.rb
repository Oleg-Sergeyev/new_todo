# frozen_string_literal: true

# module Callable
module Callable
  def self.included(base)
    base.instance_eval do
      def call(*args)
        new.call(*args)
      end
    end
  end
end

module Services
  # class UsersReport
  class UsersReport
    include Callable

    def call(from, to)
      package = Axlsx::Package.new
      workbook = package.workbook
      sheet = workbook.add_worksheet(name: I18n.t('active_admin.users').capitalize)

      scope(from, to).find_each do |user|
        sheet.add_row [user.name, user.events.size, user.items.size]
      end

      package.to_stream.read
    end

    private

    def scope(from, to)
      scope = User.includes(events: :items).order(:name)
      scope = scope.where(created_at: from..to) if from || to
      scope
    end
  end
end
