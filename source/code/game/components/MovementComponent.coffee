def "MovementComponent", [], ( m ) ->
	module =
		componentName: "movement"

		createComponent: ->
			movement =
				radius: 100
				speed : 1
