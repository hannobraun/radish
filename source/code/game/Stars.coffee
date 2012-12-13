module "Stars", [ "Movements" ], ( m ) ->
	nextEntityId = 0

	module =
		createEntity: ( args ) ->
			movement = m.Movements.createComponent()
			movement.radius = args.radius
			movement.speed  = args.speed

			id = nextEntityId
			nextEntityId += 1

			entity =
				id: "star #{ id }"
				components:
					"positions": [ 0, 0 ]
					"movements": movement
					"imageIds" : "star.png"
