module Movement
  def move_down!(window)
    @y += speed

    colliding = colliding_objects(window)

    unless colliding.empty?
      new_bottom = colliding.map do |object|
        object.rect.y1
      end.min

      @y = new_bottom - size/2
    end
  end

  def move_up!(window)
    @y -= speed

    colliding = colliding_objects(window)

    unless colliding.empty?
      new_top = colliding.map do |object|
        object.rect.y2
      end.max

      @y = new_top + size/2
    end
  end

  def move_right!(window)
    @x += speed

    colliding = colliding_objects(window)

    unless colliding.empty?
      new_right = colliding.map do |object|
        object.rect.x1
      end.min

      @x = new_right - size/2
    end
  end

  def move_left!(window)
    @x -= speed

    colliding = colliding_objects(window)

    unless colliding.empty?
      new_left = colliding.map do |object|
        object.rect.x2
      end.max

      @x = new_left + size/2
    end
  end
end
