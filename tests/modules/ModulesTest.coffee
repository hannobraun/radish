describe "Modules", ->
	beforeEach ->
		delete window.modules
	
	it "should define a simple module without dependencies", ->
		moduleLoaded = false
		module "Module", [], ( m ) ->
			moduleLoaded = true

		load( "Module" )

		expect( moduleLoaded ).to.equal( true )

	it "should pass a module's dependency into a module", ->
		dependencyModule = ""

		module "Dependency", [], ( m ) ->
			"dependency"

		module "Module", [ "Dependency" ], ( m ) ->
			dependencyModule = m.Dependency

		load( "Module" )

		expect( dependencyModule ).to.equal( "dependency" )

	it "should load every module only once", ->
		timesLoaded = 0

		module "Dependency", [], ( m ) ->
			timesLoaded += 1

		module "ModuleA", [ "Dependency" ], ( m ) ->

		module "ModuleB", [ "Dependency" ], ( m ) ->

		module "MainModule", [ "ModuleA", "ModuleB" ], ( m ) ->

		load( "MainModule" )

		expect( timesLoaded ).to.equal( 1 )

	it "should throw an error, if two modules are defined with the same id", ->
		module "Module", [], ( m ) ->

		caughtError = try
			module "Module", [], ( m ) ->
			false
		catch error
			true

		expect( caughtError ).to.equal( true )

	it "should throw a nice error message, if a a module is loaded that doesn't exist", ->
		module "Module", [], ( m ) ->

		error = try
			load( "NonExistingModule" )
			undefined
		catch error
			error

		expect( error ).to.contain( "NonExistingModule" )

	it "should throw a nice error message, if a dependency does not exist", ->
		module "ExistingModule", [ "NonExistingModule" ], ( m ) ->

		error = try
			load( "ExistingModule" )
			undefined
		catch error
			error

		expect( error ).to.contain( "ExistingModule" )
		expect( error ).to.contain( "NonExistingModule" )
