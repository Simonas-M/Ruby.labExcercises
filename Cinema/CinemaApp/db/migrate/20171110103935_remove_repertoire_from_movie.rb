# frozen_string_literal: true

class RemoveRepertoireFromMovie < ActiveRecord::Migration[5.1]
  def change
    remove_reference :movies, :repertoire, foreign_key: true
  end
end
