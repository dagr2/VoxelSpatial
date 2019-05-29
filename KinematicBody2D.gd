extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mov=Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
  if Input.is_action_pressed("ui_left"):
    mov=Vector2(-1,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  mov += Vector2(0,1)
  move_and_slide(delta*mov,Vector2(0,-1))
  
