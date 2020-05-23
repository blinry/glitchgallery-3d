extends KinematicBody

var speed = 2
var mouse_sensitivity = 0.005
var gravity = -1

var vel = Vector3()

onready var camera = $Pivot/Camera
onready var pivot = $Pivot

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
    # Walking
    var dir = Vector3()
    var cam_transform = camera.get_global_transform()
    var input_movement = Vector3()
    
    input_movement.z -= Input.get_action_strength("forward") - Input.get_action_strength("backward")
    input_movement.x += Input.get_action_strength("right") - Input.get_action_strength("left")
    
    input_movement = input_movement.normalized()
    
    if input_movement.length() != 0:
        $Footsteps.stream_paused = false
    else:
        $Footsteps.stream_paused = true
    
    dir += cam_transform.basis.z * input_movement.z
    dir += cam_transform.basis.x * input_movement.x
    
    vel.y += delta*gravity
    vel.x = dir.x*speed
    vel.z = dir.z*speed

    move_and_slide(vel, Vector3.UP, 0.05, 4)

func _input(event):
    # Looking around
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        pivot.rotate_x(-event.relative.y*mouse_sensitivity)
        rotate_y(-event.relative.x*mouse_sensitivity)
        pivot.rotation.x = clamp(pivot.rotation.x, -PI/2+0.01, PI/2-0.01)
        
    if event.is_action_pressed("ui_cancel"):
        if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
            Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
        else:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
