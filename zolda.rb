require 'bundler'
Bundler.require

Hasu.load('tile.rb')
Hasu.load('lynk.rb')
Hasu.load('screen.rb')
Hasu.load('enemy.rb')
Hasu.load('rect.rb')

class Zolda < Gosu::Window
  prepend Hasu

  module Screens
    GRAY = Screen.new(:gray)
    RED = Screen.new(:red)
    BLUE = Screen.new(:blue)
    GREEN = Screen.new(:green)
    YELLOW = Screen.new(:yellow)

    RED.up = BLUE.down = GREEN.left = YELLOW.right = GRAY
    BLUE.up = GREEN.down = YELLOW.left = GRAY.right = RED
    GREEN.up = YELLOW.down = GRAY.left = RED.right = BLUE
    YELLOW.up = GRAY.down = RED.left = BLUE.right = GREEN
    GRAY.up = RED.down = BLUE.left = GREEN.right = YELLOW

  end

  def initialize
    super(Screen::WIDTH, Screen::HEIGHT, false)
  end

  def objects
    @objects + @screen.objects
  end

  def reset
    @screen = Screens::GRAY
    @screen.on_show

    @objects =
      [
       @lynk = Lynk.new(100, 100),
      ]
  end

  def update
    objects.each{|o| o.update(self) }
    @objects.delete_if(&:dead?)
    @screen.sweep_dead
    if button_down?(Gosu::KbDown);  @lynk.move_down!(self);  end
    if button_down?(Gosu::KbUp);    @lynk.move_up!(self);    end
    if button_down?(Gosu::KbRight); @lynk.move_right!(self); end
    if button_down?(Gosu::KbLeft);  @lynk.move_left!(self);  end
  end

  def draw
    @screen.draw(self)
    @objects.each{|o| o.draw(self) }
  end

  def change_screen(direction)
    @screen = @screen.send(direction)
    @screen.on_show
  end

  def button_down(id)
    case id
    when Gosu::KbSpace
      @lynk.swordinate!
    end
  end

end

Hasu.run(Zolda)
