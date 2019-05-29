extends Spatial
export(int,2,12) var VisibleChunks = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var chunks={}
var Chunk=load("res://Chunk.gd")
var bt
var _px
var _py
var t
# Called when the node enters the scene tree for the first time.
func _ready():
  t=Thread.new()
  t.start(self,"calc_chunks",0)

func calc_chunks(ud):
    print("Thread started")
    while true:
      #var start=OS.get_unix_time()
      var ppos=get_parent().get_node("Player").translation
      var px=round((ppos.x-8)/16)*16  
      var pz=round((ppos.z-8)/16)*16
      testandcreate(px,pz)
      #var stop=OS.get_unix_time()
      #print("TOOK "+str(stop-start)+"ms")
           
func AddChunk(px,pz):
    var start=OS.get_unix_time()
    var chunk = Chunk.new(Vector3(px,0,pz),Vector3(16,16,16))
    for y in range(16):
      for x in range(16):
        chunk.SetBlock(px+x,1,pz+y,2)
    #chunk.BuildGeometryAsync()
    chunk.BuildGeometry(0)
    chunks[[px,pz]]=chunk
    print(chunk)
    call_deferred("add_child",chunk)
    #add_child(chunk)
    var stop=OS.get_unix_time()
    print("Took "+str(stop-start)+"ms")
    return chunk


export(int) var vis=3

func thelp(px,pz):
  if !chunks.has([px,pz]):
    AddChunk(px,pz)

  
func testandcreate(px,pz):
  #thelp(px*16,pz*16)
  #return
  for r in range(vis):
    for r2 in range(-r,r+1):     
      thelp(px-r2*16,pz-r*16)      
      thelp(px-r2*16,pz+r*16)      
      thelp(px-r*16,pz-r2*16)      
      thelp(px+r*16,pz-r2*16)      
      
func _process(delta):
      return
      var ppos=get_parent().get_node("Player").translation
      var px=round((ppos.x-8)/16)*16  
      var pz=round((ppos.z-8)/16)*16
      testandcreate(px,pz)