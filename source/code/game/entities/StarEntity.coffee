def 'StarEntity', [ 'Components' ], ( m ) ->
	nextEntityId = 0

	module =
		entityName: "star"

		createEntity: ( args ) ->
			movement = m.Components.create( 'movement', {
				radius: args.radius
				speed : args.speed } )

			id = nextEntityId
			nextEntityId += 1

			entity =
				id: 'Star ' +id
				components:
					'positions': m.Components.create( 'position' )
					'movements': movement
					'imageIds' : 'star.png'
