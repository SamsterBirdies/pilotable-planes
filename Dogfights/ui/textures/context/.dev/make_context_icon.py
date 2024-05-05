'''
Run this script with an argument for the source image (without extension).
Example with example.png: python make_context_icon.py example
'''

import sys
#dependency: Python Image Library
try:
	from PIL import Image, ImageDraw, ImageOps, ImageEnhance
except Exception:
	print("PIL not installed.\nInstall using command: python -m pip install pillow")
	exit(0)

#get input
if len(sys.argv) > 1:
	uSrc = sys.argv[1]
else:
	uSrc = input("Enter image name (without extension):")
#get source image
try:
	imgSrc = Image.open(uSrc + ".png")
	imgD = Image.open(uSrc + ".png").convert('LA').convert('RGBA')
except Exception:
	try:
		imgSrc = Image.open(uSrc + ".tga")
		imgD = Image.open(uSrc + ".tga").convert('LA').convert('RGBA')
	except Exception:
		try:
			imgSrc = Image.open(uSrc + ".webp")
			imgD = Image.open(uSrc + ".webp").convert('LA').convert('RGBA')
		except Exception:
			print("could not find valid file")
			exit(0)
#test image size
if imgSrc.size == (64,64):
	pass
else:
	print("invalid image size for context icons\nCorrect input image size is 64x64")
	exit(0)
#create A
imgSrc.save(f"HUD-{uSrc}-A.png", "PNG")
#create D
imgD.save(f"HUD-{uSrc}-D.png", "PNG")
#create R
imgR = ImageEnhance.Contrast(imgSrc).enhance(1.0)
imgR = ImageEnhance.Brightness(imgR).enhance(1.6)
imgR.save(f"HUD-{uSrc}-R.png", "PNG")
#create S
imgS = ImageEnhance.Contrast(imgSrc).enhance(1.0)
imgS = ImageEnhance.Brightness(imgS).enhance(2.5)
imgS.save(f"HUD-{uSrc}-S.png", "PNG")