def 'StarEntity', [ 'Components' ], ( m ) ->
	nextEntityId = 0

	module =
		createEntity: ( args ) ->
			movement = m.Components.create( 'movement' )
			movement.radius = args.radius
			movement.speed  = args.speed

			id = nextEntityId
			nextEntityId += 1

			entity =
				id: 'Star ' +id
				components:
					'positions': m.Components.create( 'position' )
					'movements': movement
					'imageIds' : 'star.png'
