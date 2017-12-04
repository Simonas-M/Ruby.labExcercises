# frozen_string_literal: true

json.array! @screenings, partial: 'screenings/screening', as: :screening
