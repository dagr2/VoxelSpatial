extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ChunkLoader = load("res://ChunkLoader.gd")
var chunkloader
# Called when the node enters the scene tree for the first time.
func _ready():
  chunkloader = ChunkLoader.new()
  add_child(chunkloader)
  
func _input(event):
        if Input.is_action_just_pressed("toggle_fullscreen"):
            OS.window_fullscreen = !OS.window_fullscreen     
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
