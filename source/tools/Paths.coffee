def "Paths", [], ( m ) ->
	modle =
		"templates"     : "source/templates/"
		"generated-code": "output/generated/"
		"game-code"     : "source/code/game/"

		"game-directories":
			"component": "components"
			"entity"   : "entities"
			"system"   : "systems"
