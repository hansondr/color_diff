module ColorDiff
  module Color
    class Lab
      attr_reader :l, :a, :b

      PRECISION = 3

      def initialize(l = 0, a = 0, b = 0)
        @l = l
        @a = a
        @b = b
      end

      def self.from_xyz(xyz)
        ref_x = 95.047
        ref_y = 100.000
        ref_z = 108.883
        x = xyz.x / ref_x
        y = xyz.y / ref_y
        z = xyz.z / ref_z

        x = normalize_xyz_component(x)
        y = normalize_xyz_component(y)
        z = normalize_xyz_component(z)

        l = (116 * y) - 16
        a = 500 * (x - y)
        b = 200 * (y - z)

        new(l, a, b)
      end

      def self.normalize_xyz_component(c)
        if c > 0.008856
          c ** (1 / 3.0)
        else
          (c * 7.787) + (16 / 116.0)
        end
      end

      def to_s
        "L#{@l.round(PRECISION)}A#{@a.round(PRECISION)}B#{@b.round(PRECISION)}"
      end
    end
  end
end
