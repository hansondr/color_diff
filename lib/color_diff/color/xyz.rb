module ColorDiff
  module Color
    class Xyz
      attr_reader :x, :y, :z

      def initialize(x = 0, y = 0, z = 0)
        @x = x
        @y = y
        @z = z
      end

      def to_lab
        Lab.from_xyz(self)
      end

      def self.from_rgb(rgb)
        r = normalize_rgb_component rgb.r
        g = normalize_rgb_component rgb.g
        b = normalize_rgb_component rgb.b

        x = r * 0.4124 + g * 0.3576 + b * 0.1805
        y = r * 0.2126 + g * 0.7152 + b * 0.0722
        z = r * 0.0193 + g * 0.1192 + b * 0.9505

        new(x, y, z)
      end

      def self.normalize_rgb_component(c)
        c = c / 255.0

        if c > 0.04045
          c = ((c + 0.055) / 1.055) ** 2.4
        else
          c = c / 12.92
        end

        c * 100
      end
    end
  end
end
