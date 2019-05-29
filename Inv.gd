extends CanvasItem

var _slot=0

export(Texture) var texture setget _set_texture
export(int,0,9) var slot=0 setget _set_slot
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var tex=Texture.new()
# Called when the node enters the scene tree for the first time.
func _ready():
  var t=Texture.new() 
  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  #draw_texture_rect_region()
  pass
  
func _draw():
  #draw_rect(Rect2(20,20,100,100),Color.beige)
  var srect=Rect2(0,0+_slot*16,16,16)
  draw_texture_rect_region(texture,Rect2(10,10,42,42),srect)
  print("Slot = "+str(srect))


func _set_texture(value):
    # if the texture variable is modified externally,
    # this callback is called.
    texture = value #texture was changed
    update() # update the node
    
func _set_slot(s):
  _slot=s
  update()
  return _slot
