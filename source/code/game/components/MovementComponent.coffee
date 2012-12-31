def "MovementComponent", [], ( m ) ->
	module =
		componentName: "movement"

		createComponent: ( args ) ->
			movement =
				radius: args.radius or 100
				speed : args.speed  or 1
