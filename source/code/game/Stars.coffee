module "Stars", [], ( m ) ->
	nextEntityId = 0

	module =
		createEntity: ( args ) ->
			movement =
				radius: args.radius
				speed : args.speed

			id = nextEntityId
			nextEntityId += 1

			entity =
				id: "star #{ id }"
				components:
					"positions": [ 0, 0 ]
					"movements": movement
					"imageIds" : "star.png"
