def 'StarEntity', [ 'PositionComponent', 'MovementComponent' ], ( m ) ->
	nextEntityId = 0

	module =
		createEntity: ( args ) ->
			movement = m.MovementComponent.createComponent()
			movement.radius = args.radius
			movement.speed  = args.speed

			id = nextEntityId
			nextEntityId += 1

			entity =
				id: 'Star ' +id
				components:
					'positions': m.PositionComponent.createComponent()
					'movements': movement
					'imageIds' : 'star.png'
