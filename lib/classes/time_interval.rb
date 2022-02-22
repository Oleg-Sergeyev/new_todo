# frozen_string_literal: true

# class Journal
class TimeInterval
  attr_accessor :start_date, :final_date, :object, :journal

  def initialize(dates, object, associated_object)
    @dates = dates.map(&:to_time)
    @object = object
    @associated_object = associated_object
    @journal = create_query
  end

  def create_query
    start = if @dates.first.nil?
              @object.minimum(:created_at).to_time.beginning_of_day
            else
              @dates.first.beginning_of_day
            end
    final = if @dates.second.nil?
              @object.maximum(:created_at).to_time.beginning_of_day
            else
              @dates.second.end_of_day
            end
    { rows: @object.where(created_at: start...final).includes(@associated_object), start_date: start,
      final_date: final }
  end
end
