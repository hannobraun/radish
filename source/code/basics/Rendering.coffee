module "Rendering", [], ( m ) ->
	module =
		drawFunctions:
			"image": ( context, properties, image, imageId ) ->
				unless image?
					throw "Image \"#{ imageId }\" can not be found."

				position    = properties.position    or [ 0, 0 ]
				orientation = properties.orientation or 0
				alpha       = properties.alpha       or 1

				context.globalAlpha = alpha

				context.translate(
					position[ 0 ],
					position[ 1 ] )
				context.rotate( orientation + image.orientationOffset )
				context.translate(
					image.positionOffset[ 0 ],
					image.positionOffset[ 1 ] )
				context.drawImage( image.rawImage, 0, 0 )
				
		createDisplay: ->
			canvas  = document.getElementById( "canvas" )
			context = canvas.getContext( "2d" )

			# Setting up the coordinate system for the context. The goal here:
			# - (0,0) should be at the center of the canvas.
			# - Positive x should be to the right, positive y downwards.
			# - Each unit should be exactly one pixel.
			context.translate(
			 	canvas.width  / 2,
			 	canvas.height / 2 )
			
			display =
				canvas : canvas
				context: context
				size   : [ canvas.width, canvas.height ]

		createRenderable: ( type, properties, reference ) ->
			renderable =
				type      : type
				properties: properties
				reference : reference

		render: ( drawFunctions, display, renderData, renderables ) ->
			context = display.context

			width  = display.size[ 0 ]
			height = display.size[ 1 ]
			
			context.clearRect(
				-width  / 2,
				-height / 2,
				width,
				height )

			for renderable in renderables
				context.save()

				resource = renderData[ renderable.type ][ renderable.reference ]

				drawRenderable = drawFunctions[ renderable.type ]
				drawRenderable(
					context,
					renderable.properties,
					resource,
					renderable.reference )

				context.restore()
