Hasu.load('rect.rb')
Hasu.load('movement.rb')

class Enemy < GameObject
  include Movement
  SIZE = 32
  SPEED = 2

  def initialize(x, y)
    @x = x
    @y = y
    new_direction
  end

  def new_direction
    @direction = [:up, :down, :left, :right].sample
  end

  def size
    SIZE
  end

  def speed
    SPEED
  end

  def update(window)
    if rand > 0.9
      new_direction
    end
    case @direction
    when :up;    move_up!(window)
    when :down;  move_down!(window)
    when :left;  move_left!(window)
    when :right; move_right!(window)
    else; raise
    end
  end

  def rect
    Rect.new(
      x1: @x - SIZE/2,
      x2: @x + SIZE/2,
      y1: @y - SIZE/2,
      y2: @y + SIZE/2,
    )
  end

  def color
    Gosu::Color::RED
  end

  def draw(window)
    rect.draw(window, color)
  end
end
