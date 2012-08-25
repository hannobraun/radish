module "Step", [], ->
	module =
		createStepData: ( stepTime ) ->
			{
				stepTime   : stepTime

				accumulator: 0
				totalTime  : 0 }

		step: ( stepData, frameTime, f ) ->
			stepData.accumulator += frameTime

			while stepData.accumulator >= stepData.stepTime
				stepData.totalTime += stepData.stepTime

				f(
					stepData.totalTime,
					stepData.stepTime )

				stepData.accumulator -= stepData.stepTime
