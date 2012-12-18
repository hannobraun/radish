module "Rendering", [], ( m ) ->
	module =
		drawFunctions:
			"image": ( context, properties, image, imageId ) ->
				unless image?
					throw "Image \"#{ imageId }\" can not be found."

				position    = properties.position    or [ 0, 0 ]
				orientation = properties.orientation or 0
				scale       = properties.scale       or [ 1, 1 ]
				alpha       = properties.alpha       or 1

				context.globalAlpha = alpha

				context.translate(
					position[ 0 ],
					position[ 1 ] )
				context.rotate( orientation + image.orientationOffset )
				context.scale(
					scale[ 0 ],
					scale[ 1 ] )
				context.translate(
					image.positionOffset[ 0 ],
					image.positionOffset[ 1 ] )
				context.drawImage( image.rawImage, 0, 0 )

			"text": ( context, properties ) ->
				text         = properties.text

				position     = properties.position    or [ 0, 0 ]
				orientation  = properties.orientation or 0
				color        = properties.color       or "rgb(255,105,180)"
				font         = properties.font        or "10pt Arial"
				alpha        = properties.alpha       or 1
				textAlign    = properties.align       or "center"
				textBaseline = properties.baseline    or "alphabetic"
				fill         = properties.fill        or true

				context.font         = font
				context.globalAlpha  = alpha
				context.textAlign    = textAlign
				context.textBaseline = textBaseline

				context.translate(
					position[ 0 ],
					position[ 1 ] )
				context.rotate( orientation )
				if fill
					context.fillStyle = color
					context.fillText( text, 0, 0 )
				else
					context.strokeStyle = color
					context.strokeText( text, 0, 0 )

			"line": ( context, properties ) ->
				start = properties.start
				end   = properties.end

				alpha = properties.alpha or 1
				color = properties.color or "rgb(0,0,0)"
				width = properties.width or 1
				cap   = properties.cap   or "butt"

				context.globalAlpha = alpha
				context.strokeStyle = color
				context.lineWidth   = width
				context.lineCap     = cap

				context.beginPath()
				context.moveTo( start[ 0 ], start[ 1 ] )
				context.lineTo( end[ 0 ], end[ 1 ] )
				context.stroke()

			"rectangle": ( context, properties ) ->
				position = properties.position
				size     = properties.size

				color = properties.color or "rgb(255,255,255)"
				fill  = properties.fill  or true

				if fill
					context.fillStyle = color
					context.fillRect(
						position[ 0 ],
						position[ 1 ],
						size[ 0 ],
						size[ 1 ] )
				else
					context.strokeStyle = color
					context.strokeRect(
						position[ 0 ],
						position[ 1 ],
						size[ 0 ],
						size[ 1 ] )

		createRenderData: ( drawFunctions, data ) ->
			renderData = {}
			
			for renderableType, drawFunction of drawFunctions
				renderData[ renderableType ] = data[ renderableType ] or {}

			renderData
				
		createDisplay: ( width, height ) ->
			canvas  = document.createElement( "canvas" )
			context = canvas.getContext( "2d" )

			canvas.width  = width
			canvas.height = height

			gameContainer = document.getElementById( "game" )
			gameContainer.appendChild( canvas )

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

				resources    = renderData[ renderable.type ]
				drawFunction = drawFunctions[ renderable.type ]

				unless drawFunction?
					throw "There is no draw function for renderable type \"#{ renderable.type }\"."

				drawFunction(
					context,
					renderable.properties,
					resources[ renderable.reference ],
					renderable.reference )

				context.restore()
