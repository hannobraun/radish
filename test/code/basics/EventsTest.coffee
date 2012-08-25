module "EventsTest", [ "Events" ], ( m ) ->
	describe "Events", ->
		events = null

		beforeEach ->
			events = m.Events.createEvents()


		describe "basic behavior", ->
			it "should call the subscriber of a published event", ->
				argumentForSubscriber = null
				m.Events.subscribe events, "keyDown", [ "enter" ], ( argument ) ->
					argumentForSubscriber = argument

				argumentFromPublisher = {}
				m.Events.publish( events, "keyDown", "enter", [ argumentFromPublisher ] )
				m.Events.execute( events )

				expect( argumentForSubscriber ).to.equal( argumentFromPublisher )

			it "should pass an event to all its subscribers", ->
				argumentForSubscriber = null
				m.Events.subscribe events, "keyDown", [ "enter" ], ( argument ) ->
					argumentForSubscriber = argument

				eventForOtherSubscriber = null
				m.Events.subscribe events, "keyDown", [ "enter" ], ( argument ) ->
					eventForOtherSubscriber = argument

				argumentFromPublisher = {}
				m.Events.publish( events, "keyDown", "enter", [ argumentFromPublisher ] )
				m.Events.execute( events )

				expect( argumentForSubscriber   ).to.equal( argumentFromPublisher )
				expect( eventForOtherSubscriber ).to.equal( argumentFromPublisher )

		describe "execution", ->
			it "should only call subscribers if events are executed", ->
				subscriberExecuted = false
				m.Events.subscribe events, "keyDown", [ "enter" ], ->
					subscriberExecuted = true

				m.Events.publish( events, "keyDown", "enter", [] )

				expect( subscriberExecuted ).to.equal( false )

			it "should execute published events only once", ->
				numberOfExecutions = 0
				m.Events.subscribe events, "keyDown", [ "enter" ], ->
					numberOfExecutions += 1

				m.Events.publish( events, "keyDown", "enter", [] )
				m.Events.execute( events )
				m.Events.execute( events )

				expect( numberOfExecutions ).to.equal( 1 )

			it "should execute events that are added to the queue during execution", ->
				eventExecuted = false
				m.Events.subscribe events, "triggeredEvent", [ "a topic" ], ->
					eventExecuted = true

				m.Events.subscribe events, "originalEvent", [ "a topic" ], ->
					m.Events.publish( events, "triggeredEvent", "a topic", [] )

				m.Events.publish( events, "originalEvent", [ "a topic" ], [] )
				m.Events.execute( events )

				expect( eventExecuted ).to.equal( true )

			it "should execute a published event right away, if calling publishNow", ->
				subscriberExecuted = false
				m.Events.subscribe events, "keyDown", [ "enter" ], ->
					subscriberExecuted = true

				m.Events.publishAndExecute( events, "keyDown", "enter", [] )

				expect( subscriberExecuted ).to.equal( true )

		describe "event types", ->
			it "should only call subscribers of the specified event type", ->
				argumentForSubscriber = null
				m.Events.subscribe events, "keyDown", [ "enter" ], ( argument ) ->
					argumentForSubscriber = argument

				m.Events.publish( events, "keyUp", "enter", [ {} ] )
				m.Events.execute( events )

				expect( argumentForSubscriber ).to.equal( null )

			it "should allow subscriptions to any event", ->
				argumentForSubscriber = null
				m.Events.subscribe events, m.Events.anyEvent, [ "enter" ], ( argument ) ->
					argumentForSubscriber = argument

				eventForOtherSubscriber = null
				m.Events.subscribe events, m.Events.anyEvent, [ "space" ], ( argument ) ->
					eventForOtherSubscriber = argument

				argumentFromPublisher = {}
				m.Events.publish( events, "keyDown", "enter", [ argumentFromPublisher ] )
				m.Events.execute( events )

				expect( argumentForSubscriber      ).to.equal( argumentFromPublisher )
				expect( eventForOtherSubscriber ).to.equal( null               )

		describe "topics", ->
			it "should only call subscribers of the specified topic", ->
				argumentForSubscriber = null
				m.Events.subscribe events, "keyDown", [ "enter" ], ( argument ) ->
					argumentForSubscriber = argument

				m.Events.publish( events, "keyDown", "space", [ {} ] )
				m.Events.execute( events )

				expect( argumentForSubscriber ).to.equal( null )

			it "should allow subscriptions to any topic", ->
				argumentForSubscriber = null
				m.Events.subscribe events, "keyDown", [ m.Events.anyTopic ], ( argument ) ->
					argumentForSubscriber = argument

				eventForOtherSubscriber = null
				m.Events.subscribe events, "keyUp", [ m.Events.anyTopic ], ( argument ) ->
					eventForOtherSubscriber = argument

				argumentFromPublisher = {}
				m.Events.publish( events, "keyDown", "enter", [ argumentFromPublisher ] )
				m.Events.execute( events )

				expect( argumentForSubscriber      ).to.equal( argumentFromPublisher )
				expect( eventForOtherSubscriber ).to.equal( null               )

		describe "robustness", ->
			it "should throw an exception, if anything but an array is passed for topics", ->
				error = try
					m.Events.subscribe( events, "keyDown", "enter", ( argument ) -> )
					false
				catch error
					true

				expect( error ).to.equal( true )

load( "EventsTest" )
