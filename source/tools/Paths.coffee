def "Paths", [], ( m ) ->
	moduleSuffix =
		"component": "Component"
		"entity"   : "Entity"
		"system"   : "System"

	module =
		"templates"     : "source/templates/"
		"generated-code": "output/generated-code/"
		"game-code"     : "source/code/game/"

		"game-directories":
			"component": "components"
			"entity"   : "entities"
			"system"   : "systems"

		moduleName: ( type, name ) ->
			name[ 0 ].toUpperCase() +
				name.substring( 1 ) +
				moduleSuffix[ type ]
