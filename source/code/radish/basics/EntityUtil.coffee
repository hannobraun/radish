def "EntityUtil", [], ( m ) ->
	module =
		createEntity: ( entities, components, type, args ) ->
			entity = entities.create( type, args )
			for componentName, component of entity.components
				unless components[ componentName ]?
					components[ componentName ] = {}

				components[ componentName ][ entity.id ] = component

			entity.id

		destroyEntity: ( components, entityId ) ->
			for componentType, componentMap of components
				delete componentMap[ entityId ]
