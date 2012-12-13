module "Graphics", [ "Rendering", "Vec2" ], ( m ) ->
	module =
		createRenderState: ( displaySize ) ->
			renderState =
				renderables: []
				displaySize: displaySize

		updateRenderState: ( renderState, gameState ) ->
			renderState.renderables.length = 0

			for entityId, position of gameState.components.positions
				imageId = gameState.components.imageIds[ entityId ]

				renderable = m.Rendering.createRenderable( "image", {
					position   : position
					orientation: 0 },
					imageId )

				renderState.renderables.push( renderable )
