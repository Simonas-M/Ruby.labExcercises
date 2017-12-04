# frozen_string_literal: true

json.extract! screening, :id, :created_at, :updated_at
json.url screening_url(screening, format: :json)
