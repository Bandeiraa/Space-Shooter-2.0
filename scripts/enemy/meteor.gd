extends EnemyTemplate
class_name Meteor

func on_area_entered(area) -> void:
	if area is AllyProjectile:
		health -= area.damage
		area.kill()
		
		if health <= 0:
			kill()
