class GameObject
  def colliding_objects(window)
    window.objects.reject do |object|
      object == self
    end.select do |object|
      object.rect.colliding?(rect)
    end
  end

  def die!
    @dead = true
  end

  def dead?
    @dead
  end

  def update(window)
  end
end
