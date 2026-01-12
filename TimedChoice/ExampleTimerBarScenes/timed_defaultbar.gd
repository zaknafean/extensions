extends ProgressBar

var half_time_reached : bool = false
var quarter_time_reached : bool = false
var finished_time_reached : bool = false


func _ready() -> void:
	value_changed.connect(_on_value_changed)


func _on_value_changed(new_value : float) -> void:
	if new_value <= 0:
		half_time_reached = false
		quarter_time_reached = false
		finished_time_reached = false


func _process(delta: float) -> void:
	if visible:
		if value < max_value * .5 and !half_time_reached:
			half_time_reached = true
			animate_timerbar()
		elif value < max_value * .25 and !quarter_time_reached:
			quarter_time_reached = true
			animate_timerbar(2)
		elif value < max_value * .1 and !finished_time_reached:
			finished_time_reached = true
			animate_timerbar(3)


func animate_timerbar(repeat : int = 1) -> void:
	var tw := create_tween()
	tw.chain()
	tw.tween_property(self, "scale", Vector2(1.25, 1.25), .2)
	tw.tween_property(self, "scale", Vector2(0.75, 0.75), .1)
	tw.tween_property(self, "scale", Vector2(1.00, 1.00), .2)
	tw.set_loops(repeat)
