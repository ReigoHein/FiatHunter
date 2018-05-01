# frozen_string_literal: true

class History
  include ActiveModel::Model
  include HTTParty
  format :json

  def self.get_api_history(base, target, date)
    JSON.parse get('%s/v1/history/%s/%s/%s' % [
      Rails.configuration.rate_history['url'], base, target, date
    ], query: { output: 'json' }).body
  end
end
