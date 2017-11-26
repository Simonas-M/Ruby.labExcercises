# frozen_string_literal: true

# class for cinema client
class Client < ApplicationRecord
  has_many :tickets
end
