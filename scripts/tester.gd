extends Area2D

var blocked = false

func test_position():
	await get_tree().process_frame  # garante atualização do overlap
	var can_move = get_overlapping_areas().is_empty()
	if can_move:
		blocked=false
