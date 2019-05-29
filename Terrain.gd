extends Spatial
var chunks={}
var Chunk=load("res://Chunk.gd")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player=global_settings.player
var t
# Called when the node enters the scene tree for the first time.
func _ready():
  var f=global_settings.start("ready")
  t=Thread.new()
  #t.start(self,"loop",0)
  global_settings.pstop(f)
    #testandcreate(1,1)

func loop(i):
    #while true:
      var f=global_settings.start("loop")
      #print("1")
      var ppos=get_node("Player").translation
      #print("1")
      var px=round((ppos.x-8)/16)*16  
      var pz=round((ppos.z-8)/16)*16
      #print("1")
      testandcreate(px,pz)
      global_settings.pstop(f)
      #print("1")
        
func testandcreate(px,pz):
  var f=global_settings.start("testandcreate")
  if !chunks.has([px,pz]):
    AddChunk(px,pz)
    global_settings.pstop(f)


func AddChunk(px,pz):
  var f=global_settings.start("AddChunk")
  var start=OS.get_unix_time()
  var chunk = Chunk.new(Vector3(px,0,pz),Vector3(16,16,16))
  for y in range(16):
    for x in range(16):
      chunk.SetBlock(px+x,1,pz+y,2)
  chunk.BuildGeometryAsync()
  chunks[[px,pz]]=chunk
  print(chunk)
  call_deferred("add_child",chunk)
  #add_child(chunk)
  global_settings.pstop(f)
  return chunk
  
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  loop(0)
    #pass
