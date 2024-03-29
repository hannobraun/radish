def 'Main', [ 'ImagePaths', 'Images', 'Rendering', 'Input', 'MainLoop', 'Step', 'Logic', 'Graphics' ], ( m ) ->
	m.Images.loadImages m.ImagePaths, ( rawImages ) ->
		images = m.Images.process( rawImages )

		renderData = m.Rendering.createRenderData( m.Rendering.drawFunctions, {
			"image": images } )

		# Some keys have unwanted default behavior on websites, like scrolling.
		# Fortunately we can tell the Input module to prevent the default
		# behavior of some keys.
		m.Input.preventDefaultFor( [
			'up arrow'
			'down arrow'
			'left arrow'
			'right arrow'
			'space' ] )

		stepData = m.Step.createStepData( 1 / 60 )

		display      = m.Rendering.createDisplay( 640, 480 )
		currentInput = m.Input.createCurrentInput( display )
		gameState    = m.Logic.createGameState()
		renderState  = m.Graphics.createRenderState( display.size )

		m.Logic.initGameState( gameState )

		m.MainLoop.execute ( gameTimeInS, frameTimeInS ) ->
			m.Step.step stepData, frameTimeInS, ( totalStepTimeInS, stepTimeInS ) ->
				m.Logic.updateGameState(
					gameState,
					currentInput,
					totalStepTimeInS,
					stepTimeInS )

			m.Graphics.updateRenderState(
				renderState,
				gameState )
			m.Rendering.render(
				m.Rendering.drawFunctions,
				display,
				renderData,
				renderState.renderables )
