# frozen_string_literal: true

# class Events < Grape::API
class Events < Grape::API
  helpers EventsHelper, ParamsHelper
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
  end
end
