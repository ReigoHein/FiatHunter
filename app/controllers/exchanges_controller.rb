# frozen_string_literal: true

class ExchangesController < ApplicationController
  def index
    @exchanges = user_exchanges
  end

  def new
    @exchange = Exchange.new
  end

  def edit
    @exchange = user_exchange
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

  def update
    @exchange = user_exchange

    if @exchange.update(exchange_params)
      redirect_to @exchange
    else
      render 'edit'
    end
  end

  def destroy
    @exchange = user_exchange
    @exchange.destroy

    redirect_to exchanges_path
  end

  def show
    @exchange = user_exchange
    @history = History.get_api_history(@exchange.base, @exchange.target,
                                       @exchange.created_at.strftime('%Y-%V'),
                                       @exchange.weeks.to_s)
  end

  private

  def exchange_params
    params.require(:exchange).permit(:base, :target, :amount, :weeks)
  end

  def user_exchange
    Exchange.where(user_id: current_user.id, id: params[:id]).first
  end

  def user_exchanges
    Exchange.where(user_id: current_user.id)
  end
end
