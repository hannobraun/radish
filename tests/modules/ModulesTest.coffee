describe "Modules", ->
	beforeEach ->
		delete window.modules
	
	it "should define a simple module without dependencies", ->
		moduleLoaded = false
		def "Module", [], ( m ) ->
			moduleLoaded = true

		load( "Module" )

		expect( moduleLoaded ).to.equal( true )

	it "should pass a module's dependency into a module", ->
		dependencyModule = ""

		def "Dependency", [], ( m ) ->
			"dependency"

		def "Module", [ "Dependency" ], ( m ) ->
			dependencyModule = m.Dependency

		load( "Module" )

		expect( dependencyModule ).to.equal( "dependency" )

	it "should load every module only once", ->
		timesLoaded = 0

		def "Dependency", [], ( m ) ->
			timesLoaded += 1

		def "ModuleA", [ "Dependency" ], ( m ) ->

		def "ModuleB", [ "Dependency" ], ( m ) ->

		def "MainModule", [ "ModuleA", "ModuleB" ], ( m ) ->

		load( "MainModule" )

		expect( timesLoaded ).to.equal( 1 )

	it "should throw an error, if two modules are defined with the same id", ->
		def "Module", [], ( m ) ->

		caughtError = try
			def "Module", [], ( m ) ->
			false
		catch error
			true

		expect( caughtError ).to.equal( true )

	it "should throw a nice error message, if a a module is loaded that doesn't exist", ->
		def "Module", [], ( m ) ->

		error = try
			load( "NonExistingModule" )
			undefined
		catch error
			error

		expect( error ).to.contain( "NonExistingModule" )

	it "should throw a nice error message, if a dependency does not exist", ->
		def "ExistingModule", [ "NonExistingModule" ], ( m ) ->

		error = try
			load( "ExistingModule" )
			undefined
		catch error
			error

		expect( error ).to.contain( "ExistingModule" )
		expect( error ).to.contain( "NonExistingModule" )
