extends KinematicBody2D


onready var map = self.get_parent()

const move = {
	"left":Vector2(-0.5, 0),
	"right":Vector2(0.5, 0),
	"up":Vector2(0, -0.5),
	"down":Vector2(0, 0.5),
	"none":Vector2()
	}

var movement = Vector2()
var prevMov = Vector2()
var speed = 0.5

var countInputs = 0



func _ready():
	movement = Vector2(0.5, 0)
	

func _physics_process(delta):
	_move()
	
#	if (self.is_coll):


func _unhandled_input(event):
	
	if !(Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")
	or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
		return
	
	if (Input.is_action_pressed("ui_right")):
		countInputs += 1
	if (Input.is_action_pressed("ui_left")):
		countInputs += 1
	if (Input.is_action_pressed("ui_up")):
		countInputs += 1
	if (Input.is_action_pressed("ui_down")):
		countInputs += 1
		
	if (countInputs > 1):
		countInputs = 0
		return
			
	if (countInputs == 1):
		if (Input.is_action_pressed("ui_right")):
			movement = move.right
		if (Input.is_action_pressed("ui_left")):
			movement = move.left
		if (Input.is_action_pressed("ui_up")):
			movement = move.up
		if (Input.is_action_pressed("ui_down")):
			movement = move.down
		
	countInputs = 0


func _move():
	
	if ((global_position.x - int(global_position.x) != 0)
	or (int(global_position.x) % 2 != 0)):
		global_position += (prevMov * speed)
		return
	if ((global_position.y - int(global_position.y) != 0)
	or (int(global_position.y) % 2 != 0)):
		global_position += (prevMov * speed)
		return

	if (movement == move.up):
		map.set_cellv((global_position - move.up)/2, 2)
	elif (movement == move.left):
		map.set_cellv((global_position - move.left)/2, 2)		
	else:
		map.set_cellv(global_position/2, 2)
		
	var aux = global_position/2
	if (map.get_cellv(aux + movement.normalized()) != 7):
		print ("aaa")
		self.queue_free()
		return
		
	global_position += (movement * speed)
	prevMov = movement
	
	return


