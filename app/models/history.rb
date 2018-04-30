# frozen_string_literal: true

class History
  include ActiveModel::Model
  include HTTParty
  format :json

  def self.get_api_history(base, target, yearWeek, weeks)
    get('%s/v1/history/%s/%s/%s/%s' % [Rails.configuration.rate_history['url'], base, target, yearWeek, weeks], query: { output: 'json' })
  end
end
