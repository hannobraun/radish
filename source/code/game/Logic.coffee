module "Logic", [ "Input", "Entities", "Vec2" ], ( m ) ->
	nextEntityId = 0

	entityFactories =
		"star": ( args ) ->
			movement =
				center: args.center
				radius: args.radius
				speed : args.speed

			id = nextEntityId
			nextEntityId += 1

			entity =
				id: id
				components:
					"positions": [ 0, 0 ]
					"movements": movement
					"imageIds" : "star.png"

	# There are functions for creating and destroying entities in the Entities
	# module. We will mostly use shortcuts however. They are declared here and
	# defined further down in initGameState.
	createEntity  = null
	destroyEntity = null

	module =
		createGameState: ->
			gameState =
				# Game entities are made up of components. The components will
				# be stored in this map.
				components: {}

		initGameState: ( gameState ) ->
			# These are the shortcuts we will use for creating and destroying
			# entities.
			createEntity = ( type, args ) ->
				m.Entities.createEntity(
					entityFactories,
					gameState.components,
					type,
					args )
			destroyEntity = ( entityId ) ->
				m.Entities.destroyEntity(
					gameState.components,
					entityId )

			createEntity( "star", {
				center: [ 0, 0 ]
				radius: 50,
				speed : 2 } )
			createEntity( "star", {
				center: [ 0, 0 ]
				radius: 100,
				speed : -1 } )

		updateGameState: ( gameState, currentInput, gameTimeInS, frameTimeInS ) ->
			for entityId, position of gameState.components.positions
				movement = gameState.components.movements[ entityId ]

				angle = gameTimeInS * movement.speed
				position[ 0 ] = movement.radius * Math.cos( angle )
				position[ 1 ] = movement.radius * Math.sin( angle )

				m.Vec2.add( position, currentInput.pointerPosition )
