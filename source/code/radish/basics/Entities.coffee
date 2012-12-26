def "Entities", [], ( m ) ->
	module =
		createEntity: ( factories, components, type, args ) ->
			factory = factories[ type ]

			unless factory?
				throw "Entity type \"#{ type }\" is not known."


			entity = factory( args )
			for componentName, component of entity.components
				unless components[ componentName ]?
					components[ componentName ] = {}

				components[ componentName ][ entity.id ] = component

			entity.id

		destroyEntity: ( components, entityId ) ->
			for componentType, componentMap of components
				delete componentMap[ entityId ]
