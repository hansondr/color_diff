require 'spec_helper'

RSpec.describe ColorDiff do
  describe '.between' do
    it 'calculates the ciede2000 distance between two Lab colors' do
      color1 = ColorDiff::Color::Lab.new(50.0, 2.5, 0.0)
      color2 = ColorDiff::Color::Lab.new(50.0, 3.1736, 0.5854)

      expect(ColorDiff.between(color1, color2)).to be_within(0.1).of(1.0)
      expect(ColorDiff.between(color2, color1)).to be_within(0.1).of(1.0)
    end
  end
end
