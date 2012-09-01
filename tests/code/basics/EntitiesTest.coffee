module "EntitiesTest", [ "Entities" ], ( m ) ->
	describe "Entities", ->
		describe "createEntity", ->
			it "should pass the creation arguments to the entity factory", ->
				args         = { a: "a", b: "b" }
				receivedArgs = undefined

				entityFactories =
					"myEntity": ( args ) ->
						receivedArgs = args

				m.Entities.createEntity( entityFactories, {}, "myEntity", args )

				expect( receivedArgs ).to.eql( args )

			it "should sort the returned components into the appropriate containers", ->
				id = "myId"
				componentA = {}
				componentB = {}

				components = {}

				entityFactories =
					"myEntity": ( args ) ->
						entity =
							id: id
							components:
								"componentA": componentA
								"componentB": componentB

				m.Entities.createEntity( entityFactories, components, "myEntity", {} )

				expect( components[ "componentA" ][ id ] ).to.be( componentA )
				expect( components[ "componentB" ][ id ] ).to.be( componentB )

			it "should return the id of the created entity", ->
				id = "myId"
				componentA = {}
				componentB = {}

				components = {}

				entityFactories =
					"myEntity": ( args ) ->
						entity =
							id: id
							components:
								"componentA": componentA
								"componentB": componentB

				returnedId = m.Entities.createEntity(
					entityFactories,
					components,
					"myEntity",
					{} )

				expect( returnedId ).to.equal( id )

		describe "destroyEntity", ->
			it "should remove an entity from the component containers", ->
				gameState =
					"componentA":
						"a": {}
						"b": {}
					"componentB":
						"a": {}
						"c": {}

				m.Entities.destroyEntity( gameState, "a" )

				expectedGameState =
					"componentA":
						"b": {}
					"componentB":
						"c": {}
				expect( gameState ).to.eql( expectedGameState )

load( "EntitiesTest" )
