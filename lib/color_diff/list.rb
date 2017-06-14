module ColorDiff
  class List
    def initialize(items)
      @items = items
    end

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
