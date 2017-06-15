module ColorDiff
  class List
    # +items+ An array of ColorDiff::Colors
    def initialize(items)
      @items = items
    end

    # Compares all +items+ in the list to the supplied +color+ and returns
    # the most similar
    #
    # +color+ ColorDiff::Color to compare against the list
    #
    # == Example
    #
    #   red    = ColorDiff::Color::RGB.new(255, 0, 0)
    #   blue   = ColorDiff::Color::RGB.new(0, 0, 255)
    #   yellow = ColorDiff::Color::RGB.new(255, 255, 0)
    #   gold   = ColorDiff::Color::RGB.new(255, 215, 0)
    #
    #   list   = ColorDiff::List.new [red, blue, yellow]
    #   list.closest_to(gold) == yellow => true
    #
    def closest_to(color)
      closest_color = nil
      closest_diff = 100

      @items.each do |item|
        diff = ColorDiff.between(color, item)
        if diff < closest_diff
          closest_diff = diff
          closest_color = item
        end
      end

      closest_color
    end

    # Compares all +items+ in the list against the supplied +palette+ and
    # maps each item to the closest palette color.  The resulting hash is 
    # returned
    #
    # +palette+ Array of ColorDiff::Colors to compare against the list
    #
    # == Example
    #
    #   red       = ColorDiff::Color::RGB.new(255, 0, 0)
    #   black     = ColorDiff::Color::RGB.new(0, 0, 0)
    #   dark_gray = ColorDiff::Color::RGB.new(80, 80, 80)
    #   maroon    = ColorDiff::Color::RGB.new(128, 0, 0)
    #
    #   list = ColorDiff::List.new [red, black]
    #   palette = [dark_gray, maroon]
    #
    #   list.closest_to_map(palette) =>
    #     { 'R255G0B0' => maroon, 'R0B0G0' => dark_gray }
    #
    def closest_to_map(palette)
      map = {}
      options = List.new(palette)
      @items.each do |item|
        map[item.to_s] = options.closest_to item
      end

      map
    end
  end
end
