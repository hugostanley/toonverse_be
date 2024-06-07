class Api::V1::HealthChecksController < ApplicationController
  def index
    health_details = {
      application: 'Toonverse - Final Project',
      developers: %w[chrrymlk xai limadelta jewls],
      timestamp: Time.current
    }

    render json: health_details
  end
end
