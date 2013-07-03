class Sword < GameObject
  WIDTH = 8
  LENGTH = 28

  attr_reader :owner

  def initialize(owner)
    @owner = owner
  end

  def x1
    case owner.direction
    when :up; owner.x - WIDTH/2
    when :down; owner.x - WIDTH/2
    when :left; owner.x1 - LENGTH
    when :right; owner.x2
    end
  end

  def x2
    case owner.direction
    when :up; owner.x + WIDTH/2
    when :down; owner.x + WIDTH/2
    when :left; owner.x1
    when :right; owner.x2 + LENGTH
    end
  end

  def y1
    case owner.direction
    when :up; owner.y1 - LENGTH
    when :down; owner.y2
    when :left; owner.y - WIDTH/2
    when :right; owner.y - WIDTH/2
    end
  end

  def y2
    case owner.direction
    when :up; owner.y1
    when :down; owner.y2 + LENGTH
    when :left; owner.y + WIDTH/2
    when :right; owner.y + WIDTH/2
    end
  end

  def color
    Gosu::Color::GRAY
  end

  def rect
    Rect.new(
             x1: x1,
             x2: x2,
             y1: y1,
             y2: y2,
             )
  end

  def draw(window)
    rect.draw(window, color)
  end
end
