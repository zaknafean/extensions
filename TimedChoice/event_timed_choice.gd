@tool
extends DialogicEvent
class_name DialogicTimedChoiceEvent

# Define properties of the event here
var time_limit : float = 15.0
var default_choice_number : float = 1.0


func _execute() -> void:
	var timed_choice_layer = dialogic.Styles.get_layout_node().get_node('TimedChoiceLayer')
	if !is_instance_valid(timed_choice_layer):
		push_warning("No Timed Choice Layer found in current layer! Make sure the current style has a TimedChoiceLayer. As a precaution a timed choice will NOT occur.")
	else:
		timed_choice_layer.time_limit = time_limit
		timed_choice_layer.default_choice_number = int(default_choice_number)
	
	finish() # called to continue with the next event


#region INITIALIZE
################################################################################
# Set fixed settings of this event
func _init() -> void:
	event_name = "Timed Choice Config"
	event_category = "Other"



#endregion

#region SAVING/LOADING
################################################################################
func get_shortcode() -> String:
	return "timed_choice"

func get_shortcode_parameters() -> Dictionary:
	return {
		#param_name 	: property_info
		"time_limit" 				: {"property": "time_limit", 		"default": 15},
		"default_choice" 	: {"property": "default_choice_number", 	"default": 1},

	}

# You can alternatively overwrite these 3 functions: to_text(), from_text(), is_valid_event()
#endregion


#region EDITOR REPRESENTATION
################################################################################

func build_event_editor() -> void:
	add_header_label("The next chioce is timed.")
	add_body_edit ("time_limit", ValueType.NUMBER, {'left_text':'Time limit to make choice in seconds:'})
	add_body_line_break()
	#add_header_label("Choice to default too on time out: ")
	add_body_edit ("default_choice_number", ValueType.NUMBER, {'left_text':'Choice to default on timeout:'})

#endregion
