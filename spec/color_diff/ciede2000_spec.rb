require 'spec_helper'

RSpec.describe ColorDiff::Ciede2000 do
  describe '.diff' do
    it 'uses true chroma difference' do
      color1 = ColorDiff::Color::Lab.new(50, 2.6772, -79.7751)
      color2 = ColorDiff::Color::Lab.new(50, 0, -82.7485)

      expect(described_class.diff(color1, color2)).to be_within(0.0001).of 2.0425
    end

    it 'uses true hue difference' do
      color1 = ColorDiff::Color::Lab.new(50, -1.3802, -84.2814)
      color2 = ColorDiff::Color::Lab.new(50, 0, -82.7485)

      expect(described_class.diff(color1, color2)).to be_within(0.1).of 1.0
    end

    it 'uses correct arctangent computation' do
      color1 = ColorDiff::Color::Lab.new(50, 0, 0)
      color2 = ColorDiff::Color::Lab.new(50, -1, 2)

      expect(described_class.diff(color1, color2)).to be_within(0.0001).of 2.3669
    end

    it 'calculates on dissimilar colors' do
      color1 = ColorDiff::Color::Lab.new(50, 2.5, 0)
      color2 = ColorDiff::Color::Lab.new(73, 25, -18)

      expect(described_class.diff(color1, color2)).to be_within(0.0001).of 27.1492
    end

    it 'produces results found in CIE tech report' do
      color1 = ColorDiff::Color::Lab.new(50, 2.5, 0)
      color2 = ColorDiff::Color::Lab.new(50, 3.1736, 0.5854)

      expect(described_class.diff(color1, color2)).to be_within(0.1).of 1
    end
  end
end
