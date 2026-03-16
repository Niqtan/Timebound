extends Node2D

const PIECE_SCENE = Constants.PACKED_MINI_GAME_SCENE_PATHS.chess_piece
const WHITE_KING = preload("res://Resources/Chess/pixel chess_v1.2/16x32 pieces/W_King.png")
const BLACK_QUEEN = preload("res://Resources/Chess/pixel chess_v1.2/16x32 pieces/B_Queen.png")

@onready var pieces = $Pieces
const TILE_SIZE = 32


var white_king_pos = Vector2i(6, 6)
var black_queen_pos = Vector2i(0, 4)

var queen_piece

var board_size = 32 * 8

var selected = false

func board_to_world(pos: Vector2i):
	return pos * TILE_SIZE
	
func world_to_board(pos: Vector2):
	return Vector2i(pos / TILE_SIZE)

func _ready() -> void:
	var screen_size = get_viewport_rect().size
	
	$Camera2D.zoom = Vector2(0.7, 0.7)
	$Camera2D.position = Vector2(board_size/2, board_size /2)
		
	spawn_piece(WHITE_KING, white_king_pos)
	spawn_piece(BLACK_QUEEN, black_queen_pos)

func spawn_piece(texture: Texture2D, board_pos: Vector2i):
	var p = PIECE_SCENE.instantiate()
	pieces.add_child(p)
	
	p.set_texture(texture)
	
	p.position = board_to_world(board_pos) + Vector2i(15, 10)
	
	if texture == BLACK_QUEEN:
		queen_piece = p

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var world_pos = $Camera2D.get_global_mouse_position()
			var tile = world_to_board(world_pos)
			print(tile)
			print(black_queen_pos)
			if not selected:
				if tile == black_queen_pos:
					selected = true
					print("queen has been selected")
			else:
				if is_valid_queen_move(black_queen_pos, tile):
					print("valid queen move!")
					black_queen_pos = tile
					move_queen()
					selected = true

func move_queen():
	queen_piece.position = board_to_world(black_queen_pos) + Vector2i(15, 10)
	
func is_valid_queen_move(from: Vector2i, to: Vector2i) -> bool:
	if from == to:
		return false
	
	# Moving horizontally
	if from.x == to.x:
		return true
	
	#Moving vertically
	if from.y == to.y:
		return true
	
	# Moving diagonally
	if abs(from.x - to.x) == abs(from.y - to.y):
		return true
	
	return false
