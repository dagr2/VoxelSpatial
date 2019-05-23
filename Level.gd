extends Spatial
var Chunk = load("res://Chunk.gd")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cs=1024

var chunk=Chunk.new(Vector3(-cs/2.0,-cs/2.0,-cs/2.0),Vector3(cs,cs,cs))
# Called when the node enters the scene tree for the first time.
func _ready():
  add_child(chunk)
  chunk.SetBlock(0,0,0,1)
    #pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
