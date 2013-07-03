class Screen
  WIDTH = 640
  HEIGHT = 480

  attr_accessor :up, :down, :left, :right
  attr_reader :objects

  def initialize(color)
    @tiles = (WIDTH/Tile::SIZE).times.flat_map do |x|
      (HEIGHT/Tile::SIZE).times.map do |y|
        Tile.new(x, y, color)
      end
    end
  end

  def on_show
    @objects =
      [
       Enemy.new(rand(WIDTH), rand(HEIGHT)),
      ]
  end

  def sweep_dead
    @objects.delete_if(&:dead?)
  end

  def draw(window)
    @tiles.each{|t| t.draw(window) }
    @objects.each{|o| o.draw(window) }
  end
end
