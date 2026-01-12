@tool
extends DialogicLayoutLayer

@onready var choice_timer: Timer = $ChoiceTimer

var time_limit : float = -1.0
var default_choice_number : int  = 1
@export_group('Visual Scene')
# The visual component of the timer. This is assumed to be a TextureBar
@export var visual_progress_scene: String = this_folder.path_join("ExampleTimerBarScenes/timed_circlebar.tscn")
var visual_progress_bar : Range


# Emitted when a decision occurs. Returns the choice dictionary info
signal times_up(default_choice_dict : Dictionary)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var visual_scene = load(visual_progress_scene).instantiate()
	if visual_scene is Range:
		visual_progress_bar = load(visual_progress_scene).instantiate()
	else:
		visual_progress_bar = load("res://addons/dialogic_additions/TimedChoice/ExampleTimerBarScenes/timed_circlebar.tscn").instantiate()
	
	add_child(visual_progress_bar)
	
	if visual_progress_bar:
		visual_progress_bar.visible = false
	choice_timer.timeout.connect(auto_select_choice)
	
	Dialogic.Choices.choice_selected.connect(stop_timer)
	Dialogic.Choices.question_shown.connect(start_timer)


func start_timer(choices: Dictionary) -> void:
	# The event does nothing if you don't set a time limit via the event
	if time_limit < 0:
		return
	
	if visual_progress_bar:
		visual_progress_bar.visible = true
	
	visual_progress_bar.max_value = time_limit
	visual_progress_bar.value = time_limit
	choice_timer.start(time_limit)


func stop_timer(_choice_info: Dictionary) -> void:
	if visual_progress_bar:
		visual_progress_bar.visible = false
	
	choice_timer.stop()
	time_limit = -1


func _process(delta: float) -> void:
	if !choice_timer.is_stopped():
		visual_progress_bar.value = choice_timer.time_left


func auto_select_choice() -> void:
	stop_timer({})
	
	var question_info := Dialogic.Choices.get_current_question_info()
	var default_choice : Dictionary = {}
	
	if question_info.size() < default_choice_number and default_choice_number > 0:
		default_choice = question_info.choices[default_choice_number - 1]
	else:
		default_choice = question_info.choices[0]
	
	Dialogic.Choices._on_choice_selected(default_choice)
	times_up.emit(default_choice)
