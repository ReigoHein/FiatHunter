# frozen_string_literal: true

class ExchangesController < ApplicationController
  def index
    @exchanges = user_exchanges
  end

  def new
    @exchange = Exchange.new
    @base_currencies = base_currencies
    @target_currencies = target_currencies
  end

  def edit
    @exchange = user_exchange
    @base_currencies = base_currencies
    @target_currencies = target_currencies
  end

  def create
    @exchange = Exchange.new(exchange_params)
    @exchange.user_id = current_user.id
    if @exchange.save
      redirect_to @exchange
    else
      @base_currencies = base_currencies
      @target_currencies = target_currencies
      render 'new'
    end
  end

  def update
    @exchange = user_exchange

    if @exchange.update(exchange_params)
      redirect_to @exchange
    else
      @base_currencies = base_currencies
      @target_currencies = target_currencies
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
    graph = predict_rate_movement(group_history_chart, @exchange.weeks)
    @calculated_graph = calculate_estimated_amounts(graph, @exchange.amount)
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

  def group_history_chart
    History.get_api_history(@exchange.base, @exchange.target,
    @exchange.created_at.strftime('%Y-%V'))
    .collect { |h| [h['week'], h['rate']] }
  end

  def predict_rate_movement(history, weeks)
    i = 0
    loop do
      last = history.last
      i += 1
      break if i == weeks
      date = next_week_date(last[0])
      history.push([date, rand_rate_movement(last[1])])
    end
    history
  end

  def next_week_date(date)
    parts = date.split('-')
    parts[0].next + '-1' if parts[1] == 52
    parts[0] + '-' + parts[1].next
  end

  def rand_rate_movement(ratestr)
    val = ratestr.to_f
    val + range(-val * 0.005, val * 0.005)
  end

  def range(min, max)
    rand * (max - min) + min
  end

  def target_currencies
    Rails.configuration.rate_history['target_currencies']
    .split(',')
  end

  def base_currencies
    Rails.configuration.rate_history['base_currencies']
    .split(',')
  end

  def calculate_estimated_amounts(values, amount)
    values.map { |h| [h[0], (h[1].to_f * amount).round(2)] }
  end
end
