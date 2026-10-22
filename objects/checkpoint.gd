extends Area3D

class_name Checkpoint

#@export var point_number: int = 1 

var cloth_start_position: Vector3

var is_active: bool = false
var player_nearby: bool = false

@onready var stick: MeshInstance3D = $Stick
@onready var cloth: MeshInstance3D = $Cloth
@onready var label: Label3D = $Label3D

func _ready() -> void:
	cloth_start_position = cloth.position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if not is_active and player_nearby:
			_activate()
		
		
func deactivate()-> void:
	is_active = false
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	var tween: Tween = create_tween()
	tween.tween_property(cloth, "position", cloth_start_position, 1.0)

func _activate()-> void:
	is_active = true
	Events.new_checkpoint.emit(self)
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	
	
	var tween: Tween = create_tween()
	tween.tween_property(cloth, "position", \
	Vector3(cloth_start_position.x, \
	cloth_start_position.y + 0.45, \
	cloth_start_position.z), 1.0)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and is_active == false:
		player_nearby = true
		label.show()

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
		label.hide()
