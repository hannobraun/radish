module "MainLoopTest", [ "MainLoop" ], ( m ) ->
	describe "MainLoop", ->
		it "should execute the given function while callNextFrame keeps re-scheduling the function", ->
			numberOfSchedulings = 2
			callNextFrame = ( f ) ->
				while numberOfSchedulings > 0
					numberOfSchedulings -= 1
					f()

			numberOfCalls = 0
			m.MainLoop.execute(
				->
					numberOfCalls += 1
				,
				callNextFrame )

			expect( numberOfCalls ).to.equal( 2 )

		it "should pass the game time and the frame time into the function (in seconds)", ->
			i = 0
			callNextFrame = ( f ) ->
				i += 1
				switch i
					when 1 then f( 9000 )
					when 2 then f( 9010 )

			lastGameTimeInS   = null
			lastFrameTimeInS  = null
			totalFrameTimeInS = 0
			m.MainLoop.execute(
				( gameTimeInS, frameTimeInS ) ->
					lastGameTimeInS  = gameTimeInS
					lastFrameTimeInS = frameTimeInS

					totalFrameTimeInS += frameTimeInS
				,
				callNextFrame )

			expect( lastGameTimeInS  ).to.equal( totalFrameTimeInS )
			expect( lastFrameTimeInS ).to.equal( 0.01 )

		it "should never call with a passed time equivalent to greater than 30 Hz, no matter how much time has passed", ->
			i = 0
			callNextFrame = ( f ) ->
				i += 1
				switch i
					when 1 then f( 8000 )
					when 2 then f( 9000 )

			getCurrentTimeInMs = -> 8000

			theFrameTimeInS = null
			m.MainLoop.execute(
				( gameTimeInS, frameTimeInS ) ->
					theFrameTimeInS = frameTimeInS
				,
				callNextFrame,
				getCurrentTimeInMs )

			expect( theFrameTimeInS ).to.equal( 1 / 30 )


load( "MainLoopTest" )
