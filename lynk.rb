Hasu.load('game_object.rb')
Hasu.load('sword.rb')
Hasu.load('movement.rb')

class Lynk < GameObject
  include Movement

  SIZE = 32
  FACE_SIZE = 4
  SPEED = 4

  attr_reader :x, :y, :direction

  def initialize(x, y)
    @x = x
    @y = y
    @direction = :right
    @sword = Sword.new(self)
    @swordinating = 0
  end

  def swordinate!
    unless swordinating?
      @swordinating = 10
    end
  end

  def swordinating?
    @swordinating > 0
  end

  def speed
    SPEED
  end

  def size
    SIZE
  end

  def update(window)
    if swordinating?
      @sword.colliding_objects(window).each(&:die!)
      @swordinating -= 1
    end
  end

  def move_down!(window)
    super

    if @y > Screen::HEIGHT
      window.change_screen(:down)
      @y -= Screen::HEIGHT
    end

    @direction = :down
  end

  def move_up!(window)
    super

    if @y < 0
      window.change_screen(:up)
      @y += Screen::HEIGHT
    end
    @direction = :up
  end

  def move_right!(window)
    super

    if @x > Screen::WIDTH
      window.change_screen(:right)
      @x -= Screen::WIDTH
    end
    @direction = :right
  end

  def move_left!(window)
    super

    if @x < 0
      window.change_screen(:left)
      @x += Screen::WIDTH
    end
    @direction = :left
  end

  def x1; @x - SIZE/2; end
  def x2; @x + SIZE/2; end
  def y1; @y - SIZE/2; end
  def y2; @y + SIZE/2; end

  def rect
    Rect.new(
      x1: x1,
      x2: x2,
      y1: y1,
      y2: y2
    )
  end

  def color
    Gosu::Color::GREEN
  end

  def face_x1
    case @direction
    when :up; rect.x1
    when :down; rect.x1
    when :left; rect.x1
    when :right; rect.x2 - FACE_SIZE
    else raise
    end
  end

  def face_x2
    case @direction
    when :up; rect.x2
    when :down; rect.x2
    when :left; rect.x1 + FACE_SIZE
    when :right; rect.x2
    else raise
    end
  end

  def face_y1
    case @direction
    when :up; rect.y1
    when :down; rect.y2 - FACE_SIZE
    when :left; rect.y1
    when :right; rect.y1
    else raise
    end
  end

  def face_y2
    case @direction
    when :up; rect.y1 + FACE_SIZE
    when :down; rect.y2
    when :left; rect.y2
    when :right; rect.y2
    else raise
    end
  end

  def face_color
    Gosu::Color::YELLOW
  end

  def draw(window)
    rect.draw(window, color)
    window.draw_quad(face_x1, face_y1, face_color, face_x2, face_y1, face_color, face_x2, face_y2, face_color, face_x1, face_y2, face_color)
    if swordinating?
      @sword.draw(window)
    end
  end
end
