module ColorDiff
  module Color
    class RGB
      attr_reader :r, :g, :b

      def initialize(r = 0, g = 0, b = 0)
        @r = r
        @g = g
        @b = b
      end

      def to_xyz
        Xyz.from_rgb(self)
      end

      def to_lab
        to_xyz.to_lab
      end

      def to_s
        "R#{@r}G#{@g}B#{@b}"
      end
    end
  end
end
