module "EventsTest", [ "Events" ], ( Events ) ->
	describe "Events", ->
		subscribers = null

		beforeEach ->
			subscribers = Events.createSubscribers()


		it "should call an event's subscriber, if the event is published", ->
			eventForSubscriber = null
			Events.subscribe subscribers, "keyDown", [ "enter" ], ( event ) ->
				eventForSubscriber = event

			eventFromPublisher = {}
			Events.publish( subscribers, "keyDown", "enter", eventFromPublisher )

			expect( eventForSubscriber ).to.equal( eventFromPublisher )

		it "should only call subscribers of the event type", ->
			eventForSubscriber = null
			Events.subscribe subscribers, "keyDown", [ "enter" ], ( event ) ->
				eventForSubscriber = event

			Events.publish( subscribers, "keyUp", "enter", {} )

			expect( eventForSubscriber ).to.equal( null )

		it "should only call subscribers of the topic", ->
			eventForSubscriber = null
			Events.subscribe subscribers, "keyDown", [ "enter" ], ( event ) ->
				eventForSubscriber = event

			Events.publish( subscribers, "keyDown", "space", {} )

			expect( eventForSubscriber ).to.equal( null )

		it "should pass an event to multiple subscribers", ->
			eventForSubscriber = null
			Events.subscribe subscribers, "keyDown", [ "enter" ], ( event ) ->
				eventForSubscriber = event

			eventForOtherSubscriber = null
			Events.subscribe subscribers, "keyDown", [ "enter" ], ( event ) ->
				eventForOtherSubscriber = event

			eventFromPublisher = {}
			Events.publish( subscribers, "keyDown", "enter", eventFromPublisher )

			expect( eventForSubscriber      ).to.equal( eventFromPublisher )
			expect( eventForOtherSubscriber ).to.equal( eventFromPublisher )

		it "should allow subscriptions to any event", ->
			eventForSubscriber = null
			Events.subscribe subscribers, Events.anyEvent, [ "enter" ], ( event ) ->
				eventForSubscriber = event

			eventForOtherSubscriber = null
			Events.subscribe subscribers, Events.anyEvent, [ "space" ], ( event ) ->
				eventForOtherSubscriber = event

			eventFromPublisher = {}
			Events.publish( subscribers, "keyDown", "enter", eventFromPublisher )

			expect( eventForSubscriber      ).to.equal( eventFromPublisher )
			expect( eventForOtherSubscriber ).to.equal( null               )

		it "should allow subscriptions to any topic", ->
			eventForSubscriber = null
			Events.subscribe subscribers, "keyDown", [ Events.anyTopic ], ( event ) ->
				eventForSubscriber = event

			eventForOtherSubscriber = null
			Events.subscribe subscribers, "keyUp", [ Events.anyTopic ], ( event ) ->
				eventForOtherSubscriber = event

			eventFromPublisher = {}
			Events.publish( subscribers, "keyDown", "enter", eventFromPublisher )

			expect( eventForSubscriber      ).to.equal( eventFromPublisher )
			expect( eventForOtherSubscriber ).to.equal( null               )

		it "should throw an exception, if anything but an array is passed for topics", ->
			error = try
				Events.subscribe( subscribers, "keyDown", "enter", ( event ) -> )
				false
			catch error
				true

			expect( error ).to.equal( true )

load( "EventsTest" )
