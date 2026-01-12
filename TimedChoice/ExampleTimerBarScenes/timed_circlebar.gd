extends TextureProgressBar

# properties specifying the beginning and ending values of the h, s, and v properties of
# the tint_progress property of the TextureProgress node (color is specified by HSV)
@export var h_start : float= 0.0
@export var h_end : float = 0.45
@export var s_start : float = 0.3
@export var s_end : float = 1.0
@export var v_start : float = 0.3
@export var v_end : float = 1.0

@onready var label : Label = $Label


func _process(delta: float) -> void:
	update_label()
	update_color()


func update_label():
	label.text = str(floor(value))


func update_color():
	# Change the hue of the progress bar as the value of the Value property changes from min to max.
	tint_progress.h = remap(value, min_value, max_value, h_start, h_end)
	# Change the saturation of the progress bar as the value of the Value property changes from min to max.
	tint_progress.s = remap(value, min_value, max_value, s_start, s_end)
	# Change the brightness of the progress bar as the value of the Value property changes from min to max.
	tint_progress.v = remap(value, min_value, max_value, v_start, v_end)
