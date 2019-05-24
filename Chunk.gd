tool
extends StaticBody

export(float) var BlockWidth=1.0
export(int) var Blocks=16

var blocks = {}
var collisionShape = CollisionShape.new()
var meshInstance=MeshInstance.new()
var mat = load("res://mat1.tres")
var oct = load("res://Octree.gd").new(Vector3(-Blocks/2,-Blocks/2,-Blocks/2),Vector3(Blocks,Blocks,Blocks))

func save_chunk(filename):
  var f=File.new()
  f.open(filename,File.WRITE)
  var data={}
  data.blocks=oct.get_blocks()
  var j = to_json(data)
  j=j.replace("(","[").replace(")","]")
  f.store_line(j)
  f.close()
  
func load_chunk(filename):
  
  var f=File.new()
  if f.file_exists(filename):
    oct.clear()
    f.open(filename,File.READ)
    #var data={}
    var l = f.get_line()
    var data=parse_json(l)
    var _blocks = data["blocks"]
    for b in _blocks:
      var pos=parse_json(b.pos)
      print(pos)
      SetBlock(pos[0],pos[1],pos[2], b.value)
    f.close()
    BuildGeometry(0)
  
func _init(pos,s):
  var Octree =load("res://Octree.gd")
  oct = Octree.new(pos,s)  
  add_child(collisionShape)
  add_child(meshInstance)

func _ready():
  pass


func get_side(norm):
    if norm==Vector3(0,1,0):
        return 0
    if norm==Vector3(0,-1,0):
        return 1
    if norm==Vector3(0,0,-1):
        return 2
    if norm==Vector3(0,0,1):
        return 3
    if norm==Vector3(-1,0,0):
        return 4
    if norm==Vector3(1,0,0):
        return 5

func clicked_at(hit):
  var pos=hit.position
  var lpos=to_local(pos)

  var norm=hit.normal
  var center = lpos-norm*BlockWidth/2.0
  var bpos=Vector3(round(center.x),round(center.y),round(center.z))
  var bnum=Vector3(round(center.x*8),round(center.y*8),round(center.z*8))
  bnum=bpos
  var side=get_side(norm)
  var v=0
  if hit.button==1:
     v=1
  if side==0:
    SetBlock(bnum.x,bnum.y+v,bnum.z,v)
  if side==1:
    SetBlock(bnum.x,bnum.y-v,bnum.z,v)
  if side==2:
    SetBlock(bnum.x,bnum.y,bnum.z-v,v)
  if side==3:
    SetBlock(bnum.x,bnum.y,bnum.z+v,v)
  if side==4:
    SetBlock(bnum.x-v,bnum.y,bnum.z,v)
  if side==5:
    SetBlock(bnum.x+v,bnum.y,bnum.z,v)

  #print("Global pos: "+str(pos))
  #print("Local pos: "+str(lpos))
  #print("Center pos: "+str(center))
  #print("Block pos: "+str(bpos))
  #print("Block num: "+str(bnum))
  #print("Button: "+str(hit.button))

  BuildGeometry(0)

var _ready
func is_ready():
  return _ready
  
func set_ready(b):
  _ready=b
    
var threads=[]
func SetBlock(x,y,z,v):
  if x==-0:
    x=0
  if y==-0:
    y=0
  if z==-0:
    z=0
  print("Set block at "+str(x)+", "+str(y)+", "+str(z)+", ")
  
  #
  #blocks[str(x)+","+str(y)+","+str(z)]=v
  oct.set_block(Vector3(x,y,z),v)
  #t.start(self,"BuildGeometry")
  #BuildGeometry(0)
  
func GetBlock(x,y,z):
  return oct.get_block(Vector3(x,y,z))
  if blocks.has(str(x)+","+str(y)+","+str(z)):
    return blocks[str(x)+","+str(y)+","+str(z)]
  else:
    return 0

func coord(bt,s,x,y):
  var ts=16.0
  var t=1.0/ts
  var tx = 1.0/6.0
  var ty=1.0/20.0
  var res=Vector2(0,0)
  res.x=tx*(s+x)
  res.y=ty*(bt-1+(1-y))
  return res
    
func BuildGeometryAsync():
  var t = Thread.new()
  threads.append(t)
  t.start(self,"BuildGeometry")
  
func BuildGeometry(i):
  var verts=[]
  var cnt=8
  var w=BlockWidth # 1.0/cnt
  var w2=w/2.0
  var drawn=0
  
  var all=oct.get_blocks()
  for block in all:
    #var block=all[i]
    var x=block.pos.x
    var y=block.pos.y
    var z=block.pos.z
    if true:    
        var b=block.value
        var btop=GetBlock(x,y+1,z)
        var bbot=GetBlock(x,y-1,z)
        var bfront=GetBlock(x,y,z-1)
        var bback=GetBlock(x,y,z+1)
        var bleft=GetBlock(x-1,y,z)
        var bright=GetBlock(x+1,y,z)
        if b>0:
            drawn+=1
        #top
        if b>0 and btop<1:  
        
          verts.append([Vector3( w*x-w2, y*w+w2, w*z-w2),coord(b,0,0,0)])
          verts.append([Vector3( w*x+w2, y*w+w2, w*z-w2),coord(b,0,1,0)])
          verts.append([Vector3( w*x-w2, y*w+w2, w*z+w2),coord(b,0,0,1)])
          
          verts.append([Vector3( w*x-w2, y*w+w2, w*z+w2),coord(b,0,1,1)])
          verts.append([Vector3( w*x+w2, y*w+w2, w*z-w2),coord(b,0,0,1)])
          verts.append([Vector3( w*x+w2, y*w+w2, w*z+w2),coord(b,0,1,0)])
        #bottom
        if b>0 and bbot<1:
          verts.append([Vector3( w*x-w2, y*w-w2, w*z-w2),coord(b,1,0,0)])
          verts.append([Vector3( w*x-w2, y*w-w2, w*z+w2),coord(b,1,1,0)])
          verts.append([Vector3( w*x+w2, y*w-w2, w*z-w2),coord(b,1,0,1)])
          
          verts.append([Vector3( w*x-w2, y*w-w2, w*z+w2),coord(b,1,1,1)])
          verts.append([Vector3( w*x+w2, y*w-w2, w*z+w2),coord(b,1,0,1)])
          verts.append([Vector3( w*x+w2, y*w-w2, w*z-w2),coord(b,1,1,1)])
          
        #front
        if b>0 and bfront<1:
          verts.append([Vector3( w*x-w2, y*w-w2, w*z-w2),coord(b,2,0,0)])
          verts.append([Vector3( w*x+w2, y*w-w2, w*z-w2),coord(b,2,1,0)])
          verts.append([Vector3( w*x-w2, y*w+w2, w*z-w2),coord(b,2,0,1)])

          verts.append([Vector3( w*x-w2, y*w+w2, w*z-w2),coord(b,2,1,1)])
          verts.append([Vector3( w*x+w2, y*w-w2, w*z-w2),coord(b,2,0,1)])
          verts.append([Vector3( w*x+w2, y*w+w2, w*z-w2),coord(b,2,1,0)])
        #back
        if b>0 and bback<1:
          verts.append([Vector3( w*x-w2, y*w-w2, w*z+w2),coord(b,3,0,0)])
          verts.append([Vector3( w*x-w2, y*w+w2, w*z+w2),coord(b,3,0,1)])
          verts.append([Vector3( w*x+w2, y*w-w2, w*z+w2),coord(b,3,1,0)])

          verts.append([Vector3( w*x-w2, y*w+w2, w*z+w2),coord(b,3,1,1)])
          verts.append([Vector3( w*x+w2, y*w+w2, w*z+w2),coord(b,3,1,0)])
          verts.append([Vector3( w*x+w2, y*w-w2, w*z+w2),coord(b,3,0,1)])
        
        #left
        if b>0 and bleft<1:
          verts.append([Vector3( w*x-w2, y*w-w2, w*z-w2),coord(b,4,0,0)])
          verts.append([Vector3( w*x-w2, y*w+w2, w*z-w2),coord(b,4,0,1)])
          verts.append([Vector3( w*x-w2, y*w-w2, w*z+w2),coord(b,4,1,0)])

          verts.append([Vector3( w*x-w2, y*w-w2, w*z+w2),coord(b,4,1,1)])
          verts.append([Vector3( w*x-w2, y*w+w2, w*z-w2),coord(b,4,1,0)])
          verts.append([Vector3( w*x-w2, y*w+w2, w*z+w2),coord(b,4,0,1)])
        #right
        if b>0 and bright<1:
          verts.append([Vector3( w*x+w2, y*w-w2, w*z-w2),coord(b,5,0,0)])
          verts.append([Vector3( w*x+w2, y*w-w2, w*z+w2),coord(b,5,0,1)])
          verts.append([Vector3( w*x+w2, y*w+w2, w*z-w2),coord(b,5,1,0)])

          verts.append([Vector3( w*x+w2, y*w-w2, w*z+w2),coord(b,5,1,1)])
          verts.append([Vector3( w*x+w2, y*w+w2, w*z+w2),coord(b,5,1,0)])
          verts.append([Vector3( w*x+w2, y*w+w2, w*z-w2),coord(b,5,0,1)])
  var conc=ConcavePolygonShape.new()
  var vertarr=[]
  for v in verts:
    vertarr.append(v[0])
  conc.set_faces(vertarr)
  
  collisionShape.shape=conc
  var st = SurfaceTool.new()
  st.begin(Mesh.PRIMITIVE_TRIANGLES)
  for vert in verts:
    st.add_uv(vert[1])
    st.add_vertex(vert[0])
  st.generate_normals()
  st.set_material(mat)        
  meshInstance.mesh=st.commit()
  print(str(drawn)+" blocks drawn")    
