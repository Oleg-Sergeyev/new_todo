# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

  # GET /event/items or /event/items.json
  def index
    
    # @event_items = Item.where(event_id: Event.include(:items).pluck(:id))
    @event = session[:event_id] ?  Event.find(session[:event_id]) : Event.find(params[:event_id])
    @item = session[:id] ? Item.find(session[:id]) : Item.find(params[:id])
  
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    # @items = Item.where("event_id = #{params[:event_id]}")
  end

  # GET /event/items/1 or /event/items/1.json
  def show
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # GET /event/items/new
  def new
    session[:event_id] = params[:event_id]
    @item = Item.new(event_id: session[:event_id])
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # GET /event/items/1/edit
  def edit
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    @event = Event.find(params[:event_id])
  end

  # POST /event/items or /event/items.json
  def create
    @item = Item.new(item_params.merge(event_id: session[:event_id]))
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    # binding.pry
    respond_to do |format|
      if @item.save
        format.html { redirect_to event_path(@item.event_id), notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
        session[:event_id] = nil
      else
        #binding.pry
        format.html { render :new, event_id: session[:event_id] }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event/items/1 or /event/items/1.json
  def update
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event/items/1 or /event/items/1.json
  def destroy
    @item.destroy
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    respond_to do |format|
      format.html { redirect_to event_path(@item.event_id), notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
      session[:event_id] = nil
      session[:id] = nil
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
    session[:id] = params[:id]
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, :done, :event_id, :id)
  end
end
