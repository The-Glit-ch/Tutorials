extends Camera2D

var speed_x = 20
var speed_y = 20


func _physics_process(_delta):
	if Input.is_action_pressed("ui_up"):
		translate(Vector2(0,-speed_y))
	if Input.is_action_pressed("ui_down"):
		translate(Vector2(0,speed_y))
	if Input.is_action_pressed("ui_left"):
		translate(Vector2(-speed_x,0))
	if Input.is_action_pressed("ui_right"):
		translate(Vector2(speed_x,0))
