# frozen_string_literal: true

class ExchangeController < ApplicationController
  def index
    @exchanges = Exchange.where(user_id: current_user.id)
  end

  def new
    @exchange = Exchange.new
  end

  def create
    @exchange = Exchange.new(exchange_params)
    @exchange.user_id = current_user.id
    if @exchange.save
      redirect_to @exchange
    else
      render 'new'
    end
  end

  def show
    @exchange = Exchange.where(user_id: current_user.id, id: params[:id]).first
  end

  private

  def exchange_params
    params.require(:exchange).permit(:base, :target, :amount, :weeks)
  end
end
