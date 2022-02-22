# frozen_string_literal: true

# class EventsController
class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def edit
    authorize @event
  end

  def update
    authorize @event
  end

  def destroy
    authorize @event
  end

  @rows_count = 5

  def index
    default_cookies(@rows_count) unless cookies[:start_date] || cookies[:final_date]
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    @start_date = cookies[:start_date].to_time
    @final_date = cookies[:final_date].to_time
    @users = User.includes(:events)
    events = one_query
    @events = TimeInterval.new([@start_date, @final_date], policy_scope(events), :items)
                          .journal[:rows].page(params[:page]).per(cookies[:rows_count])
  end

  def default_cookies(rows_count)
    cookies.permanent[:start_date] = DateTime.now.beginning_of_day
    cookies.permanent[:final_date] = DateTime.now.end_of_day
    cookies.permanent[:rows_count] = rows_count
  end

  def update_cookies
    cookies.permanent[:start_date] = @start_date
    cookies.permanent[:final_date] = @final_date
  end

  # GET /events/1 or /events/1.json
  def show
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # POST /events or /events.json
  def create
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    if %i[start_date final_date].all? { |s| event_params.key? s }
      render_interval_query(event_params[:rows_count], event_params[:start_date], event_params[:final_date])
    else
      @event = policy_scope(Event).new(event_params.merge(user: User.find(current_user.id)))
      respond_to do |format|
        if @event.save
          format.html { redirect_to event_url(@event), notice: 'Event was successfully created.' }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    authorize @event
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    authorize @event
    @event.destroy
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :user_name, :content, :done, :user, :created_at, :start_date, :final_date,
                                  :rows_count)
  end

  def render_interval_query(rows_count, start_date, final_date)
    cookies.permanent[:rows_count] = rows_count
    @rows_count = rows_count
    @users = User.includes(:events)
    events = one_query
    data = TimeInterval.new([start_date, final_date], policy_scope(events), :items).journal
    @events = data[:rows].page(params[:page]).per(@rows_count)
    @start_date = data[:start_date]
    @final_date = data[:final_date]
    update_cookies
    render :index
  end

  def one_query
    # sql = '(SELECT name FROM users WHERE id = events.user_id) as user_name,
    #       (SELECT COUNT(*) FROM items WHERE event_id = events.id) as count_items,
    #       id, name, content, done, user_id, finished_at, created_at'
    # Event.select(sql)
    Event.includes(:user)
    # sql = 'SELECT
    #         (SELECT name FROM users WHERE id = events.user_id) as user_name,
    #         id,
    #         name,
    #         content,
    #         done,
    #         user_id,
    #         finished_at,
    #         created_at
    #         FROM events'
    # ActiveRecord::Base.connection.exec_query(sql)
    # User.event.group(:id).count
    # User.joins(:events).group(:user_id).size
    # Event.select(:id, { user_id: 'COUNT(id)' }).group(:id)
  end
end
