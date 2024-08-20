extends Node2D

func _ready():
	$BlobSplash.position = $BlobSplash.position.lerp(Vector2(0,-45), 0.3)
	$BlobSplash2.position = $BlobSplash.position.lerp(Vector2(35,-34), 0.3)
	$BlobSplash3.position = $BlobSplash.position.lerp(Vector2(45,0), 0.3)
	$BlobSplash4.position = $BlobSplash.position.lerp(Vector2(0,45), 0.3)
	$BlobSplash5.position = $BlobSplash.position.lerp(Vector2(35,34), 0.3)
	$BlobSplash6.position = $BlobSplash.position.lerp(Vector2(-35,34), 0.3)
	$BlobSplash7.position = $BlobSplash.position.lerp(Vector2(-45,0), 0.3)
	$BlobSplash8.position = $BlobSplash.position.lerp(Vector2(-35,-34), 0.3)
