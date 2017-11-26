# frozen_string_literal: true

class CreateCinemas < ActiveRecord::Migration[5.1]
  def change
    create_table :cinemas, &:timestamps
  end
end
