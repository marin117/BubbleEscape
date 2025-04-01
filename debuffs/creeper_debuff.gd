extends BaseDebuff

@export var debuff_burst_limit : float = 0.3

func apply(target: Node2D) -> void:
	target.bubble_burst_limit = debuff_burst_limit
