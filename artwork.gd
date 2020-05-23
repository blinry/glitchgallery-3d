tool
extends Spatial

export(Texture) var texture setget set_texture
onready var image = $Image
onready var canvas = $Image/Canvas

func set_texture(t):
    texture = t
    if Engine.editor_hint:
        recalc_size()
        
func recalc_size():
    if texture:
        image = $Image
        canvas = $Image/Canvas
        
        print(texture.load_path)
        image.get_surface_material(0).albedo_texture = texture
        var size = texture.get_size()
        size /= 500
        image.mesh.size.x = size.x
        image.mesh.size.y = size.y
        canvas.mesh.size.x = size.x
        canvas.mesh.size.y = size.y

func _ready():
    recalc_size()
