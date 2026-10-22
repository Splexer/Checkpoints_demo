extends Node3D

var player: Player

var active_checkpoint: Checkpoint
var last_checkpoint_coins: int = 0

var resettable_objects: Array = []

func _ready() -> void:
	if RenderingServer.get_current_rendering_method() == "gl_compatibility":
		# Reduce background and sun brightness when using the Compatibility renderer;
		# this tries to roughly match the appearance of Forward+.
		# This compensates for the different color space and light rendering for lights with shadows enabled.
		$Sun.light_energy = 0.24
		$Sun.shadow_opacity = 0.85
		$Environment.environment.background_energy_multiplier = 0.25
	Events.new_checkpoint.connect(_set_new_checkpoint)
	Events.resettable_object_used.connect(_handle_resettable_object_used)
	Events.player_fell.connect(_restart_level)
	player = get_tree().get_first_node_in_group("player") as Player
	

	

func _restart_level()-> void:
	if active_checkpoint == null:
		get_tree().reload_current_scene()
	else:
		player.call_deferred("teleport_to", active_checkpoint.global_position)
		player.update_coins(last_checkpoint_coins)
	for object in resettable_objects:
		object.reset()
	resettable_objects.clear()
		
	
		
func _handle_resettable_object_used(object)-> void:
	if not resettable_objects.has(object) and !object.is_queued_for_deletion():
		resettable_objects.append(object)

func _set_new_checkpoint(checkpoint: Checkpoint)-> void:
	if active_checkpoint != null:
		active_checkpoint.deactivate()
	for object in resettable_objects:
		object.queue_free()
	resettable_objects.clear()
		
		
	active_checkpoint = checkpoint
	last_checkpoint_coins = player.coins
		
	
