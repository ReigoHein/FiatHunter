# frozen_string_literal: true

class Exchange < ApplicationRecord
  validates :base, presence: true,
                   length: { minimum: 3, maximum: 3 }
  validates :target, presence: true,
                     length: { minimum: 3, maximum: 3 }
  validates :amount, presence: true,
                     numericality: {
                       only_integer: true
                     }
  validates :weeks, presence: true,
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 1,
                      less_than_or_equal_to: 25
                    }

  private
  def is_valid_base_currency
    
  end

  def is_valid_target_currency

  end
end
