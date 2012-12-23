module "MovementComponent", [], ( m ) ->
	module =
		createComponent: ->
			movement =
				radius: 100
				speed : 1
