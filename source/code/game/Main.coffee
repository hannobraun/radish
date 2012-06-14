module "Main", [ "Images", "Rendering", "Input", "MainLoop", "Logic", "Graphics" ], ( m )->
	m.Images.loadImages [ "images/star.png" ], ( rawImages ) ->
		images = m.Images.process( rawImages )

		renderData =
			"image": images

		# Some keys have unwanted default behavior on websites, like scrolling.
		# Fortunately we can tell the Input module to prevent the default
		# behavior of some keys.
		m.Input.preventDefaultFor( [
			"up arrow"
			"down arrow"
			"left arrow"
			"right arrow"
			"space" ] )

		display      = m.Rendering.createDisplay()
		currentInput = m.Input.createCurrentInput( display )
		gameState    = m.Logic.createGameState()
		renderState  = m.Graphics.createRenderState()

		m.Logic.initGameState( gameState )

		m.MainLoop.execute ( gameTimeInS, frameTimeInS ) ->
			m.Logic.updateGameState(
				gameState,
				currentInput,
				gameTimeInS,
				frameTimeInS )
			m.Graphics.updateRenderState(
				renderState,
				gameState )
			m.Rendering.render(
				m.Rendering.drawFunctions,
				display,
				renderData,
				renderState.renderables )
