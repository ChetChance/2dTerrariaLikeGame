extends Sprite


var mousePos

# Called when the node enters the scene tree for the first time.
func _process(delta):
	position.x = round(float(get_global_mouse_position().x /64)) * 64 - 32
	position.y = round(float(get_global_mouse_position().y /64)) * 64 - 32
