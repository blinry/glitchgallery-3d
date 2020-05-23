tool
extends Spatial

export var title = "Lorem Ipsum" setget set_title
export var attribution = "Some Person, 1234" setget set_attribution
export(String, MULTILINE) var description = "Lorem ipsum dolor sit amet. Blubber bla und noch viel mehr." setget set_description

func set_title(t):
    title = t
    
func set_attribution(t):
    attribution = t

func set_description(t):
    description = t

func _ready():
    pass

func _process(delta):
    var titleText = $Viewport/Control/Title
    titleText.text = title
    var attributionText = $Viewport/Control/Attribution
    attributionText.text = attribution
    var descriptionText = $Viewport/Control/Description
    descriptionText.text = description
