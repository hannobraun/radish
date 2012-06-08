module "MainLoop", [], ->
	maxPassedTimeInMs = 1000 / 30

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
				passedTimeInMs   = currentTimeInMs - previousTimeInMs
				previousTimeInMs = currentTimeInMs

				passedTimeInMs = Math.min( passedTimeInMs, maxPassedTimeInMs )

				currentTimeInS = currentTimeInMs / 1000
				passedTimeInS  = passedTimeInMs  / 1000

				f(
					currentTimeInS,
					passedTimeInS )

				callNextFrame( mainLoop )

			callNextFrame( mainLoop )
