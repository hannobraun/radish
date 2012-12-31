def "Logic", [ "Input", "EntityUtil", "Entities", "Systems" ], ( m ) ->
	# There are functions for creating and destroying entities in the EntityUtil
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
				m.EntityUtil.createEntity(
					m.Entities,
					gameState.components,
					type,
					args )
			destroyEntity = ( entityId ) ->
				m.EntityUtil.destroyEntity(
					gameState.components,
					entityId )

			createEntity( "star", {
				radius: 50,
				speed : 2 } )
			createEntity( "star", {
				radius: 100,
				speed : -1 } )

		updateGameState: ( gameState, currentInput, gameTimeInS, frameTimeInS ) ->
			m.Systems.execute( "updateStarPositions", [
				currentInput,
				gameTimeInS,
				gameState.components.positions,
				gameState.components.movements ] )
