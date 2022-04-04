# frozen_string_literal: true

class StatsController < ApplicationController
  before_action :calc_events

  def index
    @stat_users = get_data # User.order(:name)
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  def get_data
    # Item.group(:event_id).size
    # Event.group(:user_id).size)
    sql = 'SELECT
           users.*,
           (SELECT COUNT(*) FROM events WHERE user_id = users.id) AS count_events,
           SUM(i.count_item) AS items_count
           FROM users
           JOIN (SELECT user_id, (SELECT COUNT(*) FROM items WHERE event_id = events.id)
           AS count_item FROM events) i ON i.user_id = users.id
           GROUP BY users.id, users
           ORDER BY users.name ASC;'
    ActiveRecord::Base.connection.exec_query(sql)
    # Rails.logger.info "*********#{ActiveRecord::Base.connection.exec_query(sql).last}************"
  end

  private

  def calc_events
    User.all.each do |user|
      Rails.cache.write(user.name, user.events.count)
      #Rails.logger.info "++++++++++++  #{Rails.cache.read(user.name)} ++++++++++++"
    end
  end
end
