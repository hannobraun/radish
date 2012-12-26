def "Events", [], ( m ) ->
	module =
		anyEvent: "any event"
		anyTopic: "any topic"

		createEvents: ->
			{
				subscribers: {}
				queue      : [] }

		subscribe: ( events, eventType, topics, subscriber ) ->
			unless topics instanceof Array
				throw "You must specify an array of topics."

			subscribersOfEventByTopic = events.subscribers[ eventType ]
			unless subscribersOfEventByTopic?
				subscribersOfEventByTopic = {}

			for topic in topics
				subscribersOfTopic = subscribersOfEventByTopic[ topic ]
				unless subscribersOfTopic?
					subscribersOfTopic = []

				subscribersOfTopic.push( subscriber )

				subscribersOfEventByTopic[ topic ] = subscribersOfTopic

			events.subscribers[ eventType ] = subscribersOfEventByTopic

		publish: ( events, eventType, topic, args ) ->
			events.queue.push( {
				type : eventType
				topic: topic
				args : args } )

		execute: ( events ) ->
			i = 0
			while i < events.queue.length
				queuedEvent = events.queue[ i ]
				i += 1

				publishToSubscribersOfEvent(
					events.subscribers[ queuedEvent.type ],
					queuedEvent.topic,
					queuedEvent.args )
				publishToSubscribersOfEvent(
					events.subscribers[ module.anyEvent ],
					queuedEvent.topic,
					queuedEvent.args )

			events.queue.length = 0

		publishAndExecute: ( events, eventType, topic, args ) ->
			module.publish( events, eventType, topic, args )
			module.execute( events )


	publishToSubscribersOfEvent = ( subscribersOfEventByTopic, topic, args )->
		if subscribersOfEventByTopic?
			publishToSubscribersOfTopic(
				subscribersOfEventByTopic[ topic ],
				args )
			publishToSubscribersOfTopic(
				subscribersOfEventByTopic[ module.anyTopic ],
				args )

	publishToSubscribersOfTopic = ( subscribersOfTopic, args ) ->
		if subscribersOfTopic?
			for subscriber in subscribersOfTopic
				subscriber.apply( undefined, args )


	module
