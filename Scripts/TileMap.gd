extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var inventory = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("1"):
		inventory = 5
	if Input.is_action_just_pressed("2"):
		inventory = 3
	if Input.is_action_just_pressed("3"):
		inventory = 6
	if Input.is_action_just_pressed("4"):
		inventory = 7
	if Input.is_action_just_pressed("5"):
		inventory = 0
	if Input.is_action_pressed("Attack"):
		$Timer.start()
	if Input.is_action_pressed("place"):
		if($NewPiskel.position.x < 0 and $NewPiskel.position.y < 0):
			self.set_cell(($NewPiskel.position.x - 64)/get_cell_size().x,($NewPiskel.position.y - 64)/get_cell_size().y, inventory)
		elif($NewPiskel.position.x < 0):
			self.set_cell(($NewPiskel.position.x - 64)/get_cell_size().x,$NewPiskel.position.y/get_cell_size().y, inventory)
		elif($NewPiskel.position.y < 0):
			self.set_cell($NewPiskel.position.x/get_cell_size().x,($NewPiskel.position.y - 64)/get_cell_size().y, inventory)
		else:
			self.set_cell($NewPiskel.position.x/get_cell_size().y,$NewPiskel.position.y/get_cell_size().x, inventory)


func _on_Timer_timeout():
	if($NewPiskel.position.x < 0 and $NewPiskel.position.y < 0):
		self.set_cell(($NewPiskel.position.x - 64)/get_cell_size().x,($NewPiskel.position.y - 64)/get_cell_size().y, -1)
	elif($NewPiskel.position.x < 0):
		self.set_cell(($NewPiskel.position.x - 64)/get_cell_size().x,$NewPiskel.position.y/get_cell_size().y, -1)
	elif($NewPiskel.position.y < 0):
		self.set_cell($NewPiskel.position.x/get_cell_size().x,($NewPiskel.position.y - 64)/get_cell_size().y, -1)
	else:
		self.set_cell($NewPiskel.position.x/get_cell_size().x,$NewPiskel.position.y/get_cell_size().y, -1)
	$Timer.stop()
	$Timer.set_wait_time(2)
