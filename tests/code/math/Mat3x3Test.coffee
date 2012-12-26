def "Mat3x3Test", [ "Mat3x3" ], ( m ) ->
	describe "Mat3x3", ->
		it "should multiply two matrices", ->
			m1 = [
				[ 1, 2, 3 ]
				[ 4, 5, 6 ]
				[ 7, 8, 9 ] ]
			m2 = [
				[ 9, 8, 7 ]
				[ 6, 5, 4 ]
				[ 3, 2, 1 ] ]

			m.Mat3x3.multiply( m1, m2 )

			expect( m1 ).to.eql( [
				[  30,  24, 18 ]
				[  84,  69, 54 ]
				[ 138, 114, 90 ] ] )

load( "Mat3x3Test" )
