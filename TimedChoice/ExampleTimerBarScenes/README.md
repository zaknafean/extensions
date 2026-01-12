This extension allows for time limited choices within Dialogic. It contians one new custom layer (timed_choice_layer.tscn) one new event (event_timed_choice), an example timeline using the new event (timed_choice_example.dtl) and two example scenes to visualize the timer (timed_circlebar.tscn and timed_defaultbar.tscn)


In order to use the extension, please do the following
* Godot version of 4.4 or higher (for uuid simplification)
* Take the provided zip and drop the TimedChoices folder into the default 'dialogic extension folder' (res://addons/dialogic_extensions by default, this may need to be created)
* Reload project
* Add the a custom layer to your style, the new Timed Choice Layer
* Add the Timed Choice Config to your timeline, before a choice you want to make 'timed', and set the configurations.

If you use the event without adding the Timed Choice Layer, it will push a warning, but otherwise run the decision as a normal choice.
If the visualizer is improperly selected, or isn't of type Range, it will fall back to the default circle bar.
If the default timeout choice is out of bounds, it defaults to the first choice available.

@author Cyzaine