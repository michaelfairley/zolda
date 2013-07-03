class Tile
  SIZE = 32
  PADDING = 1

  def initialize(x, y, color)
    @x = x
    @y = y
    @color = color
  end

  def x1
    @x * SIZE + 1
  end

  def x2
    x1 + SIZE - PADDING*2
  end

  def y1
    @y * SIZE + 1
  end

  def y2
    y1 + SIZE - PADDING*2
  end

  def color
    {
      :gray => Gosu::Color.argb(0xff222222),
      :red => Gosu::Color.argb(0xff442222),
      :blue => Gosu::Color.argb(0xff224422),
      :green => Gosu::Color.argb(0xff222244),
      :yellow => Gosu::Color.argb(0xff224444),
   }.fetch(@color)
  end

  def draw(window)
    window.draw_quad(x1, y1, color, x2, y1, color, x2, y2, color, x1, y2, color)
  end
end
