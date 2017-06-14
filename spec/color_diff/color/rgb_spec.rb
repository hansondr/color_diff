require 'spec_helper'

RSpec.describe ColorDiff::Color::RGB do
  describe '.new' do
    it 'is initialized with r, g, b values' do
      red = described_class.new(255, 0, 0)

      expect(red.to_s).to eq 'R255G0B0'
    end

    it 'defaults r, g, b to black by default' do
      black = described_class.new

      expect(black.to_s).to eq 'R0G0B0'
    end
  end

  describe '#to_s' do
    it 'returns a string following the pattern of R#B#G#' do
      r = 1
      g = 2
      b = 3
      expected_result = "R#{r}G#{g}B#{b}"
      color = described_class.new(r, g, b)

      expect(color.to_s).to eq expected_result
    end
  end

  describe '#to_lab' do
    it 'returns a Lab color object' do
      rgb = described_class.new(55, 100, 130)
      lab = rgb.to_lab
      expected_lab_result = "L40.473A-6.106B-21.417"

      expect(lab).to be_instance_of ColorDiff::Color::Lab
      expect(lab.to_s).to match expected_lab_result
    end

    it 'correctly converts black' do
      black = described_class.new
      lab = black.to_lab
      expected_lab_result = "L0.0A0.0B0.0"

      expect(lab.to_s).to match expected_lab_result
    end

    it 'correctly converts white' do
      white = described_class.new(255, 255, 255)
      lab = white.to_lab
      expected_lab_result = "L100.0A0.005B-0.01"

      expect(lab.to_s).to match expected_lab_result
    end
  end
end
