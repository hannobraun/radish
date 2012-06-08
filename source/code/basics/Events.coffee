module "Events", [], ->
	publishToSubscribersOfEvent = ( subscribersByTopic, topic, event )->
		if subscribersByTopic?
			publishToSubscribersOfSubject(
				subscribersByTopic[ topic ],
				event )
			publishToSubscribersOfSubject(
				subscribersByTopic[ module.anyTopic ],
				event )

	publishToSubscribersOfSubject = ( subscribersOfTopic, event ) ->
		if subscribersOfTopic?
			for subscriber in subscribersOfTopic
				subscriber( event )
			

	module =
		anyEvent: "any event"
		anyTopic: "any topic"

		createSubscribers: ->
			{}

		subscribe: ( subscribers, eventType, topics, subscriber ) ->
			unless topics instanceof Array
				throw "You must specify an array of topics."

			subscribersByTopic = subscribers[ eventType ]
			unless subscribersByTopic?
				subscribersByTopic = {}

			for topic in topics
				subscribersOfTopic = subscribersByTopic[ topic ]
				unless subscribersOfTopic?
					subscribersOfTopic = []

				subscribersOfTopic.push( subscriber )

				subscribersByTopic[ topic ] = subscribersOfTopic

			subscribers[ eventType ] = subscribersByTopic

		publish: ( subscribers, eventType, topic, event ) ->
			publishToSubscribersOfEvent(
				subscribers[ eventType ],
				topic,
				event )
			publishToSubscribersOfEvent(
				subscribers[ module.anyEvent ],
				topic,
				event )
