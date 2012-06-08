module "MainLoopTest", [ "MainLoop" ], ( MainLoop ) ->
	describe "MainLoop", ->
		it "should execute the given function while callNextFrame keeps re-scheduling the function", ->
			numberOfSchedulings = 2
			callNextFrame = ( f ) ->
				while numberOfSchedulings > 0
					numberOfSchedulings -= 1
					f()

			numberOfCalls = 0
			MainLoop.execute(
				->
					numberOfCalls += 1
				,
				callNextFrame )

			expect( numberOfCalls ).to.equal( 2 )

		it "should pass the current time and the passed time into the function (in seconds)", ->
			i = 0
			callNextFrame = ( f ) ->
				i += 1
				switch i
					when 1 then f( 9000 )
					when 2 then f( 9010 )

			lastCurrentTimeInS = null
			lastPassedTimeInS  = null
			MainLoop.execute(
				( currentTimeInS, passedTimeInS ) ->
					lastCurrentTimeInS = currentTimeInS
					lastPassedTimeInS  = passedTimeInS
				,
				callNextFrame )

			expect( lastCurrentTimeInS ).to.equal( 9.01 )
			expect( lastPassedTimeInS  ).to.equal( 0.01 )

		it "should never call with a passed time equivalent to greater than 30 Hz, no matter how much time has passed", ->
			i = 0
			callNextFrame = ( f ) ->
				i += 1
				switch i
					when 1 then f( 8000 )
					when 2 then f( 9000 )

			getCurrentTimeInMs = -> 8000

			thePassedTimeInS = null
			MainLoop.execute(
				( currentTimeInS, passedTimeInS ) ->
					thePassedTimeInS  = passedTimeInS
				,
				callNextFrame,
				getCurrentTimeInMs )

			expect( thePassedTimeInS ).to.equal( 1 / 30 )

load( "MainLoopTest" )
