require 'color_diff/color/rgb'
require 'color_diff/color/xyz'
require 'color_diff/color/lab'
require 'color_diff/ciede2000'
require 'color_diff/list'

module ColorDiff
  # = Color Diff
  #
  # Color Diff contains a number of methods to assist in measuring how similar
  # or dissimilar colors are from one another
  #
  # == Simple Comparison
  #
  # Two color objects can be compared like so:
  #
  #   yellow = ColorDiff::Color::RGB.new(255, 255, 0)
  #   gold   = ColorDiff::Color::RGB.new(255, 215, 0)
  #   ColorDiff.between(yellow, gold) => 11.584521223499245
  #
  # The higher the result the more dissimilar the colors, e.g.
  #
  #   blue = ColorDiff::Color::RGB.new(0, 0, 255)
  #   red  = ColorDiff::Color::RGB.new(255, 0, 0)
  #   ColorDiff.between(blue, red) => 52.87867414046132
  #
  # See ColorDiff::List for example of more complex comparisons

  def self.between(lab1, lab2)
    lab1 = lab1.to_lab unless lab1.is_a? Color::Lab
    lab2 = lab2.to_lab unless lab2.is_a? Color::Lab

    ColorDiff::Ciede2000.diff(lab1, lab2)
  end
end
