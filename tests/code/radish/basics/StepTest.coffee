def "StepTest", [ "Step" ], ( m ) ->
	describe "Step", ->
		it "should step, if the frame time is large enough", ->
			stepTime = 20
			stepData = m.Step.createStepData( stepTime )

			numberOfSteps = 0
			m.Step.step stepData, 20, ( totalStepTime, stepTime ) ->
				numberOfSteps += 1

			expect( numberOfSteps ).to.equal( 1 )

		it "should step multiple times, if the frame time is large enough", ->
			stepTime = 20
			stepData = m.Step.createStepData( stepTime )

			numberOfSteps = 0
			m.Step.step stepData, 40, ( totalStepTime, stepTime ) ->
				numberOfSteps += 1

			expect( numberOfSteps ).to.equal( 2 )

		it "should accumulate the remainder of the frame", ->
			stepTime = 20
			stepData = m.Step.createStepData( stepTime )

			numberOfSteps = 0
			m.Step.step stepData, 30, ( totalStepTime, stepTime ) ->
				numberOfSteps += 1
			m.Step.step stepData, 30, ( totalStepTime, stepTime ) ->
				numberOfSteps += 1

			expect( numberOfSteps ).to.equal( 3 )

		it "should pass the total stepped time and the step time into the function", ->
			stepTime = 20
			stepData = m.Step.createStepData( stepTime )

			lastTotalStepTime = null
			lastStepTime      = null
			m.Step.step stepData, 50, ( totalStepTime, stepTime ) ->
				lastTotalStepTime = totalStepTime
				lastStepTime      = stepTime

			expect( lastTotalStepTime ).to.equal( 40 )
			expect( lastStepTime      ).to.equal( 20 )


load( "StepTest" )
