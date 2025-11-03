extends Node2D
const SPEED=50

var left=true;

func _ready():
	$mushi.play("default")


func _process(_delta: float) -> void:
	if left:
		position.x+= -SPEED * _delta
		await get_tree().create_timer(2).timeout
		left=false;
	else:
		$mushi.flip_h=true;
		position.x-= -SPEED * _delta
		await get_tree().create_timer(2).timeout
		left=true;
		$mushi.flip_h=false ;


func _on_killzone_body_entered(body: Node2D) -> void:
	$killzone/ukillmezone.disabled=true
	$mushi.play("death")
	await get_tree().create_timer(1).timeout
	queue_free()
	
	
