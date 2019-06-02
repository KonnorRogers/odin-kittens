# frozen_string_literal: true

class Kitten < ApplicationRecord
  letters_only = /\A[A-Za-z]+\z/

  validates :name, presence: true,
                   length: { minimum: 2, maximum: 20 },
                   format: { with: letters_only }

  %i[cuteness softness].each do |attr|
    validates attr,
              presence: true,
              numericality: { only_integer: true,
                              greater_than: 0,
                              less_than_or_equal_to: 10 }
  end

  validates :age, presence: true,
                  numericality: { only_integer: true,
                                  greater_than: 0,
                                  less_than: 100 }
end
