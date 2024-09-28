class_name GroundTileHelpers
extends Node


static var SHAPE_UP_DOWN_INFO = {
	GridTileData.TileTopType.FLAT: {
		GridTileData.TileHighlight.FULL: {
			"up": {
				"height": +1,
				"rotation": 0,
			},
			"down": {
				"height": -1,
				"rotation": 0,
			},
		},
		GridTileData.TileHighlight.CORNER_1: {
			"up": {
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
				"rotation": 2,
			},
			"down": {
				"height": -1,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
				"rotation": 0,
			},
		},
		GridTileData.TileHighlight.CORNER_2: {
			"up": {
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
				"rotation": 1,
			},
			"down": {
				"height": -1,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
				"rotation": 3,
			},
		},
		GridTileData.TileHighlight.CORNER_3: {
			"up": {
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
				"rotation": 0,
			},
			"down": {
				"height": -1,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
				"rotation": 2,
			},
		},
		GridTileData.TileHighlight.CORNER_4: {
			"up": {
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
				"rotation": 3,
			},
			"down": {
				"height": -1,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
				"rotation": 1,
			},
		},
	},
	GridTileData.TileTopType.ONE_CORNER_UP: {
		GridTileData.TileHighlight.FULL: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
		},
		GridTileData.TileHighlight.CORNER_1: {
			"up": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.V,
			},
			"down": {
				"height": -1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.DIAGONAL_SLOPE,
			},
		},
		GridTileData.TileHighlight.CORNER_2: {
			"up": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.TWO_CORNER_UP,
			},
			"down": {
				"height": -1,
				"rotation": 3,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_3: {
			"up": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.DIAGONAL_SLOPE,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
		},
		GridTileData.TileHighlight.CORNER_4: {
			"up": {
				"rotation": 3,
				"new_tile_type": GridTileData.TileTopType.TWO_CORNER_UP,
			},
			"down": {
				"height": -1,
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
		},
	},
	GridTileData.TileTopType.TWO_CORNER_UP: {
		GridTileData.TileHighlight.FULL: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
		},
		GridTileData.TileHighlight.CORNER_1: {
			"up": {
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
			"down": {
				"height": -1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.DIAGONAL_SLOPE,
			},
		},
		GridTileData.TileHighlight.CORNER_2: {
			"up": {
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.DIAGONAL_SLOPE,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_3: {
			"up": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.DIAGONAL_SLOPE,
			},
			"down": {
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_4: {
			"up": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
			"down": {
				"height": -1,
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.DIAGONAL_SLOPE,
			},
		},
	},
	GridTileData.TileTopType.THREE_CORNER_UP: {
		GridTileData.TileHighlight.FULL: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
		},
		GridTileData.TileHighlight.CORNER_1: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
			"down": {
				"height": -1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.DIAGONAL_SLOPE,
			},
		},
		GridTileData.TileHighlight.CORNER_2: {
			"up": {
				"height": +1,
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
			"down": {
				"rotation": 3,
				"new_tile_type": GridTileData.TileTopType.TWO_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_3: {
			"up": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.DIAGONAL_SLOPE,
			},
			"down": {
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.V,
			},
		},
		GridTileData.TileHighlight.CORNER_4: {
			"up": {
				"height": +1,
				"rotation": 3,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.TWO_CORNER_UP,
			},
		},
	},
	GridTileData.TileTopType.DIAGONAL_SLOPE: {
		GridTileData.TileHighlight.FULL: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_1: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
			"down": {
				"height": -1,
			},
		},
		GridTileData.TileHighlight.CORNER_2: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.TWO_CORNER_UP,
			},
			"down": {
				"rotation": 3,
				"new_tile_type": GridTileData.TileTopType.TWO_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_3: {
			"up": {
				"height": +1,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_4: {
			"up": {
				"height": +1,
				"rotation": 3,
				"new_tile_type": GridTileData.TileTopType.TWO_CORNER_UP,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.TWO_CORNER_UP,
			},
		},
	},
	GridTileData.TileTopType.V: {
		GridTileData.TileHighlight.FULL: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.FLAT,
			},
		},
		GridTileData.TileHighlight.CORNER_1: {
			"up": {
				"height": +1,
				"rotation": 2,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
			"down": {
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_2: {
			"up": {
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
			"down": {
				"height": -1,
				"rotation": 3,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_3: {
			"up": {
				"height": +1,
				"rotation": 0,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
			"down": {
				"rotation": 2,
				"new_tile_type": GridTileData.TileTopType.ONE_CORNER_UP,
			},
		},
		GridTileData.TileHighlight.CORNER_4: {
			"up": {
				"rotation": 3,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
			"down": {
				"height": -1,
				"rotation": 1,
				"new_tile_type": GridTileData.TileTopType.THREE_CORNER_UP,
			},
		},
	},
}
