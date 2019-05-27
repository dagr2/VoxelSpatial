extends Spatial
export(int,2,12) var VisibleChunks = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var chunks={}
var Chunk=load("res://Chunk.gd")
var bt
var _px
var _py
# Called when the node enters the scene tree for the first time.
func _ready():
  pass
        
func AddChunk(px,pz,chunk):
    for y in range(16):
      for x in range(16):
        chunk.SetBlock(px+x,1,pz+y,2)
    chunk.BuildGeometryAsync()


var vis=3
func thelp(px,pz):
  if !chunks.has([px,pz]):
    var chunk = Chunk.new(Vector3(px,0,pz),Vector3(16,16,16))
    AddChunk(px,pz,chunk)
    chunks[[px,pz]]=chunk
    call_deferred("add_child",chunk)
    #add_child(chunk)
  
func testandcreate(px,pz):
  for r in range(vis):
    for r2 in range(-r,r+1):     
      thelp(px-r2*16,pz-r*16)      
      thelp(px-r2*16,pz+r*16)      
      thelp(px-r*16,pz-r2*16)      
      thelp(px+r*16,pz-r2*16)      
      
func _process(delta):
  var ppos=get_parent().get_node("Player").translation
  var px=round((ppos.x-8)/16)*16  
  var pz=round((ppos.z-8)/16)*16
  testandcreate(px,pz)
