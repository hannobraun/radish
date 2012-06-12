module "MainLoop", [], ->
	maxFrameTimeInMs = 1000 / 30

	defaultCallNextFrame =
		window.requestAnimationFrame ||
			window.webkitRequestAnimationFrame ||
			window.mozRequestAnimationFrame ||
			window.oRequestAnimationFrame ||
			window.msRequestAnimationFrame ||
			( f ) ->
				window.setTimeout(
					->
						f( Date.now() )
					, 1000 / 60 )

	module =
		execute: ( f, callNextFrame ) ->
			callNextFrame = callNextFrame || defaultCallNextFrame

			previousTimeInMs = null

			mainLoop = ( currentTimeInMs ) ->
				frameTimeInMs    = currentTimeInMs - previousTimeInMs
				previousTimeInMs = currentTimeInMs

				frameTimeInMs = Math.min( frameTimeInMs, maxFrameTimeInMs )

				gameTimeInS  = currentTimeInMs / 1000
				frameTimeInS = frameTimeInMs   / 1000

				f(
					gameTimeInS,
					frameTimeInS )

				callNextFrame( mainLoop )

			callNextFrame( mainLoop )
