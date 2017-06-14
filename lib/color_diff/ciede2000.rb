module ColorDiff
  class Ciede2000
    def self.diff(c1, c2)
      # get lab values for color 1
      l1 = c1.l
      a1 = c1.a
      b1 = c1.b

      # get lab values for color 2
      l2 = c2.l
      a2 = c2.a
      b2 = c2.b

      # weight factors
      kl = 1
      kc = 1
      kh = 1

      # Step 1: Calculate c1p, c2p, h1p, h2p
      #
      c1 = Math.sqrt((a1 ** 2) + (b1 ** 2))
      c2 = Math.sqrt((a2 ** 2) + (b2 ** 2))

      a_c1_c2 = (c1 + c2) / 2.0

      g = 0.5 * (1 - Math.sqrt((a_c1_c2 ** 7.0) / ((a_c1_c2 ** 7.0) + (25.0 ** 7.0))))

      a1p = (1.0 + g) * a1
      a2p = (1.0 + g) * a2
      c1p = Math.sqrt((a1p ** 2) + (b1 ** 2))
      c2p = Math.sqrt((a2p ** 2) + (b2 ** 2))
      h1p = hp_f(b1, a1p)
      h2p = hp_f(b2, a2p)

      # Step 2: calculate dlp, dcp, dhp
      #
      dlp = l2 - l1
      dcp = c2p - c1p
      dhp_tmp = dhp_f(c1, c2, h1p, h2p)
      dhp = 2 * Math.sqrt(c1p * c2p) * Math.sin(radians(dhp_tmp) / 2.0)

      # Step 3: calculate CIEDE2000 Color-Difference
      #
      a_l = (l1 + l2) / 2.0
      a_cp = (c1p + c2p) / 2.0
      a_hp = a_hp_f(c1, c2, h1p, h2p)
      t = 1 -
          0.17 * Math.cos(radians(a_hp - 30)) +
          0.24 * Math.cos(radians(2 * a_hp)) +
          0.32 * Math.cos(radians(3 * a_hp + 6)) -
          0.20 * Math.cos(radians(4 * a_hp - 63))
      d_ro = 30 * Math.exp(-(((a_hp - 275) / 25) ** 2))
      rc = Math.sqrt((a_cp ** 7.0) / ((a_cp ** 7.0) + (25.0 ** 7.0)))
      sl = 1 + ((0.015 * ((a_l - 50) ** 2)) / Math.sqrt(20 + ((a_l - 50) ** 2.0)))
      sc = 1 + 0.045 * a_cp
      sh = 1 + 0.015 * a_cp * t
      rt = -2 * rc * Math.sin(radians(2 * d_ro))
      de = Math.sqrt(
             ((dlp / (sl * kl)) ** 2) +
             ((dcp / (sc * kc)) ** 2) +
             ((dhp / (sh * kh)) ** 2) + 
             rt * (dcp / (sc * kc)) * (dhp / (sh * kh)) )

      de
    end

    def self.degrees(n)
      180 / Math::PI * n
    end

    def self.radians(n)
      Math::PI / 180 * n
    end

    def self.hp_f(x, y)
      0 if x.zero? && y.zero?

      tmphp = degrees Math.atan2(x, y)
      if tmphp >= 0
        tmphp
      else
        tmphp + 360
      end
    end

    def self.dhp_f(c1, c2, h1p, h2p)
      diff = h2p - h1p

      if c1 * c2 == 0
        0
      elsif diff.abs <= 180
        diff
      elsif diff > 180
        diff - 360
      elsif diff < -180
        diff + 360
      end
    end

    def self.a_hp_f(c1, c2, h1p, h2p)
      sum = h1p + h2p
      diff = h1p - h2p

      if c1 * c2 == 0
        sum
      elsif diff.abs <= 180
        sum / 2.0
      elsif diff.abs > 180 && sum < 360
        (sum + 360) / 2.0
      elsif diff.abs > 180 && sum >= 360
        (sum - 360) / 2.0
      end
    end
  end
end
