def 'UpdateStarPositionsSystem', [ 'Vec2' ], ( m ) ->
	( currentInput, gameTimeInS, positions, movements ) ->
		for entityId, position of positions
			movement = movements[ entityId ]

			angle = gameTimeInS * movement.speed
			position[ 0 ] = movement.radius * Math.cos( angle )
			position[ 1 ] = movement.radius * Math.sin( angle )

			m.Vec2.add( position, currentInput.pointerPosition )
