extends Navigation2D
class_name Floor2D

export var character_speed := 400.0
export var _character : NodePath

onready var character : Node2D = get_node(_character)
var path = []

func _process(delta):
	var walk_distance = character_speed * delta
	move_along_path(walk_distance)

# The "click" event is a custom input action defined in
# Project > Project Settings > Input Map tab.
func _input(event):
	if not event.is_action_pressed("left_click"):
		return
	
	var ch_pos = character.position
	var mouse_pos = get_local_mouse_position()
	_update_navigation_path(ch_pos, mouse_pos)

func move_along_path(distance):
	var last_point = character.position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			var weight = distance / distance_between_points
			character.position = last_point.linear_interpolate(path[0], weight)
			return

		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)

	# The character reached the end of the path.
	character.position = last_point
	set_process(false)

func _update_navigation_path(start_position, end_position):
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = get_simple_path(start_position, end_position, true)

	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)
	set_process(true)
