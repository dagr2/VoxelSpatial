extends Spatial

export(int) var vis=5

var chunks={}
var wg=load("res://WorldGenerator.gd").new()
var Chunk=load("res://Chunk2.gd")
var bt
var _px
var _py
var t

func _ready():
  t=Thread.new()
  t.start(self,"calc_chunks",0)

func calc_chunks(ud):
    print("Thread started")
    while true:
      var ppos=get_parent().get_node("Player").translation
      var px=round((ppos.x-8)/16)*16
      var pz=round((ppos.z-8)/16)*16
      testandcreate(px,pz)

func AddChunk(px,pz):
    #if px!=0 or pz !=0:
      #return
    if px==-0:
      px=0
    if pz == -0:
      pz=0
    var t=global_settings.start("AddChunk")
    var chunk = Chunk.new(self, Vector3(px,0,pz),Vector3(16,16,16))

    for z in range(16):
      for x in range(16):
        var h=floor(wg.get_height(px+x,pz+z))
        for y in range(h):
          chunk.SetBlock(px+x,y,pz+z,wg.get_block(px+x,y,pz+z))

    global_settings.set_chunk(str([px,pz]),chunk)
    call_deferred("add_child",chunk)
    chunk.BuildGeometry(0)
    global_settings.pstop(t)
    return chunk

func get_block(x,y,z):
  var cx=floor(x/16)*16
  var cy=floor(z/16)*16
  if global_settings.has_chunk(str([cx,cy])):
    var c=global_settings.get_chunk(str([cx,cy]))
    return c.GetBlock(x,y,z)
  else:
    return wg.get_block(x,y,z)

func set_block(x,y,z,v):
  var t=global_settings.start("BuildGeometry")
  var cx=floor(x/16)*16
  var cy=floor(z/16)*16
  if global_settings.has_chunk(str([cx,cy])):
    var c=global_settings.get_chunk(str([cx,cy]))
    c.SetBlock(x,y,z,v)
    c.BuildGeometry(0);
  else:
    print(global_settings.chunks.keys())
    
  global_settings.pstop(t)

func get_wg():
  return wg

func thelp(px,pz):
  if px==-0:
    px=0
  if pz==-0:
    pz=0
  if !global_settings.has_chunk(str([px,pz])):
    AddChunk(px,pz)

func testandcreate(px,pz):
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