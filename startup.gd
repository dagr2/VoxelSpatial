extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  var root = get_tree().get_root()
  root.connect("size_changed",self,"resize")
  #OS.set_window_fullscreen(true)
  set_process_input(true)
  
func resize():
  var root=get_node("/root")
  var resolution=root.get_viewport().size
  print(resolution)
  
func _input(event):
    print(event)
    #if event == KEY_ESCAPE:
      #get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
