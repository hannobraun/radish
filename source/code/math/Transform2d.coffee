module "Transform2d", [], ->
	module =
		identityMatrix: ->
			[
				[ 1, 0, 0 ]
				[ 0, 1, 0 ]
				[ 0, 0, 1 ] ]

		translationMatrix: ( v ) ->
			[
				[ 1, 0, v[ 0 ] ]
				[ 0, 1, v[ 1 ] ]
				[ 0, 0,      1 ] ]

		rotationMatrix: ( angle ) ->
			[
				[ Math.cos( angle ), -Math.sin( angle ), 0 ]
				[ Math.sin( angle ),  Math.cos( angle ), 0 ]
				[                 0,                  0, 1 ] ]

		scalingMatrix: ( factor ) ->
			[
				[ factor,      0, 0 ]
				[      0, factor, 0 ]
				[      0,      0, 1 ] ]
