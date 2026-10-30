require "rails_helper"

RSpec.describe Forecast do
  def forecast(current_temperature)
    described_class.new(current_temperature:, max_temperature: 30, min_temperature: 0, unit: "°C", timezone: nil, fetched_at: Time.current)
  end

  describe "#feel" do
    it { expect(forecast(25).feel).to eq(:hot) }
    it { expect(forecast(18.4).feel).to eq(:mild) }
    it { expect(forecast(10).feel).to eq(:cold) }
  end
end
