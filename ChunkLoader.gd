extends Spatial
#export(int,2,12) var VisibleChunks = 1
export(int) var vis=3

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var chunks={}
var wg=load("res://WorldGenerator.gd").new()
var Chunk=load("res://Chunk2.gd")
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
    var chunk = Chunk.new(self, Vector3(px,0,pz),Vector3(16,16,16))
    
    for z in range(16):
      for x in range(16):
        var h=floor(wg.get_height(px+x,pz+z))
        for y in range(h):
          #print("Adding block "+str([px+x,y,pz+z]))
          chunk.SetBlock(px+x,y,pz+z,wg.get_block(px+x,y,pz+z))

    chunks[str([px,pz])]=chunk
    call_deferred("add_child",chunk)
    #add_child(chunk)
    chunk.BuildGeometry(0)
    var stop=OS.get_unix_time()
    #print("Took "+str(stop-start)+"ms")
    #print("Added chunk "+str([px,pz]))
    return chunk



func get_block(x,y,z):
  #print("cl.getblock")
  var cx=floor(x/16)*16
  var cy=floor(z/16)*16
  if chunks.has(str([cx,cy])):
    var c=chunks[str([cx,cy])]
    #print("has it")
    return c.GetBlock(x,y,z)
  else:
    #print("miss it "+str(cx)+" "+str(cy))
    return wg.get_block(x,y,z)    

func set_block(x,y,z,v):
  var cx=floor(x/16)*16
  var cy=floor(z/16)*16  
  #print([cx,cy])
  #print([x,y,z,v])
  if chunks.has(str([cx,cy])):
   # print("has it")
    var c=chunks[str([cx,cy])]
    c.SetBlock(x,y,z,v)
    c.BuildGeometry(0);
  else:
    #var c=chunks[[cx,cy]]
    #print(c)
    #print("missing "+str([cx,cy]))
    print(chunks.keys())

func get_wg():
  return wg
  
func thelp(px,pz):
  if !chunks.has(str([px,pz])):
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