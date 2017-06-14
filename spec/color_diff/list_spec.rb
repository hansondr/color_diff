require 'spec_helper'

RSpec.describe ColorDiff::List do
  describe '#closest_to' do
    it 'returns a list color item closest to the target color' do
      red = ColorDiff::Color::RGB.new(255, 0, 0)
      green = ColorDiff::Color::RGB.new(0, 255, 0)
      blue = ColorDiff::Color::RGB.new(0, 0, 255)
      list = described_class.new [red, green, blue]
      maroon = ColorDiff::Color::RGB.new(128, 0, 0)

      expect(list.closest_to(maroon)).to match red
    end

    it 'returns a list color item for closest but dissimilar target color' do
      black = ColorDiff::Color::RGB.new
      white = ColorDiff::Color::RGB.new(255, 255, 255)
      dark = ColorDiff::Color::RGB.new(100, 45, 80)
      list = described_class.new [black, dark, white]
      maroon = ColorDiff::Color::RGB.new(128, 0, 0)

      expect(list.closest_to(maroon)).to match dark
    end
  end

  describe '#closest_to_map' do
    it 'returns a hash of results matching rgb values to items from the list' do
      black = ColorDiff::Color::RGB.new
      white = ColorDiff::Color::RGB.new(255, 255, 255)
      yellow = ColorDiff::Color::RGB.new(255, 255, 0)
      blue = ColorDiff::Color::RGB.new(0, 0, 255)
      list = described_class.new [black, white, yellow, blue]

      navy = ColorDiff::Color::RGB.new(0, 0, 128)
      slate_gray = ColorDiff::Color::RGB.new(112, 128, 144)
      ivory = ColorDiff::Color::RGB.new(255, 255, 240)
      khaki = ColorDiff::Color::RGB.new(240, 230, 140)
      palette = [navy, slate_gray, ivory, khaki]

      map = list.closest_to_map(palette)

      expect(map[black.to_s]).to match navy
      expect(map[white.to_s]).to match ivory
      expect(map[yellow.to_s]).to match khaki
      expect(map[blue.to_s]).to match navy
    end
  end
end
