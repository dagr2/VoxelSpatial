extends Node

var _vchunks
var player

var times={}

export(int,0,15) var vchunks=1 setget set_vchunks,get_vchunks
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func get_vchunks():
    return _vchunks
    
func set_vchunks(c):
    _vchunks=c
    
func start(f):
    var time={}
    time.f=f
    time.t = OS.get_unix_time()
    times[f]=time
    return f
    
func stop(f):
    var time=times[f]
    return OS.get_unix_time() - time.t

func pstop(f): 
  var d=stop(f)
  if d>1:
    print(f+" took "+str(d)+"ms")
    
 