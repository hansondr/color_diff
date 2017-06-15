# Color Diff

Calculating differences between colors using the CIEDE2000 algorithm

## Install

    gem install color_diff

## Usage

Difference between two colors:

    yellow = ColorDiff::Color::RGB.new 255, 255, 0
    gold   = ColorDiff::Color::RGB.new 255, 215, 0

    ColorDiff.between yellow, gold
    # => 11.584521223499245

Picking the most similar color from a list:

    red    = ColorDiff::Color::RGB.new 255,   0,   0
    blue   = ColorDiff::Color::RGB.new   0,   0, 255
    yellow = ColorDiff::Color::RGB.new 255, 255,   0
    gold   = ColorDiff::Color::RGB.new 255, 215,   0

    list   = ColorDiff::List.new [red, blue, yellow]
    list.closest_to(gold) == yellow
    # => true

Building a map of nearest match colors from a finite palette:

    red       = ColorDiff::Color::RGB.new 255,  0,  0
    black     = ColorDiff::Color::RGB.new   0,  0,  0
    dark_gray = ColorDiff::Color::RGB.new  80, 80, 80
    maroon    = ColorDiff::Color::RGB.new 128,  0,  0

    list = ColorDiff::List.new [red, black]
    palette = [dark_gray, maroon]

    list.closest_to_map(palette)
    # => { 'R255G0B0' => maroon, 'R0B0G0' => dark_gray }
