# frozen_string_literal: true

require_relative 'helpers/event_filters_helper'
require_relative 'helpers/params_helper'

# class Events < Grape::API
class Events < Grape::API
  helpers EventFiltersHelper, ParamsHelper
  include Grape::Kaminari

  resource :events do
    desc 'Список дел'
    params do
      use :filters
      use :pagination, per_page: 4, max_per_page: 4, offset: 0
    end
    get '/' do
      present events_scope(params[:all]), with: Entities::EventIndex
    end

    route_param :event_id, type: Integer do
      before do
        @event = Event.find params[:event_id]
      end
      get '/' do
        present @event, with: Entities::Event
      end
      post '/' do
        @event.destroy
      end
    end
    resource :created do
      route_param :order, type: String do
        before do
          @event = Event.order(created_at: params[:order])
        end
        get '/' do
          present @event, with: Entities::Event
        end
      end
    end
    resource :updated do
      params do
        use :pagination, per_page: 4, max_per_page: 4, offset: 0
      end
      route_param :order, type: String do
        before do
          @event = Event.order(updated_at: params[:order])
        end
        get '/' do
          present paginate(@event), with: Entities::Event
        end
      end
    end
  end
end
