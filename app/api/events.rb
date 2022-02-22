# frozen_string_literal: true

module ParamsHelper
  extend Grape::API::Helpers

  params :filters do
    optional :all,
             type: Boolean,
             desc: 'весь список, включая завершенные'
  end
end

module FiltersHelper
  extend Grape::API::Helpers

  def events_scope(all)
    scope = Event.includes(user: :role).order(:id)
    all ? scope : scope.where(done: false)
  end
end

class Events < Grape::API
  helpers ParamsHelper, FiltersHelper
  include Grape::Kaminari

  resource :events do
    desc 'Список дел'
    params do
      use :filters
      use :pagination, per_page: 4, max_per_page: 4, offset: 0
    end
    get '/' do
      #Event.all
      scope = EventPolicy::Scope.new(current_user, events_scope(params[:all])).resolve

      #present scope, with: Entities::EventIndex
      present paginate(scope), with: Entities::EventIndex
    end
    route_param :event_id, type: Integer do
      before do
        #@event = Event.find params[:event_id]
        scope = EventPolicy::Scope.new(current_user, Event).resolve
        @event = scope.find params[:event_id]
      end
      get '/' do
        @event
      end
      post '/' do
        @event.destroy
      end
    end
  end
end
