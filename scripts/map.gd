extends Sprite2D

var scroll_speed = 100  # pixels/sec
var scroll_offset := 0.0

#func _ready():
	#region_enabled = true
	#region_rect = Rect2(Vector2.ZERO, get_viewport_rect().size)
	
#func _ready():
	#region_enabled = true
	#region_rect = Rect2(Vector2(0, -(get_viewport_rect().size.y / 2)), get_viewport_rect().size)
	
func _ready():
	region_enabled = true
	region_rect = Rect2(Vector2.ZERO, get_viewport_rect().size)
	scale = get_viewport_rect().size / region_rect.size

func _process(delta):
	scroll_offset += scroll_speed * delta
	region_rect.position.x = scroll_offset
