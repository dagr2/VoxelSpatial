extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  var c=$Chunk
  for z in range(0,4):
    for y in range(0,4):
      for x in range(0,4):
        c.SetBlock(x*2,y*2,z*2,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
