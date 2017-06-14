require 'color_diff/color/rgb'
require 'color_diff/color/xyz'
require 'color_diff/color/lab'
require 'color_diff/ciede2000'
require 'color_diff/list'

module ColorDiff
  def self.between(lab1, lab2)
    lab1 = lab1.to_lab unless lab1.is_a? Color::Lab
    lab2 = lab2.to_lab unless lab2.is_a? Color::Lab

    ColorDiff::Ciede2000.diff(lab1, lab2)
  end
end
