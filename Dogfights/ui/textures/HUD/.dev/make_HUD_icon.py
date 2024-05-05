'''
Run this script with an argument for the source image (without extension).
Example with example.png: python make_HUD_icon.py example
'''

import sys
#dependency: Python Image Library
try:
	from PIL import Image, ImageDraw, ImageOps, ImageEnhance
except Exception:
	print("PIL not installed.\nInstall using command: python -m pip install pillow")
	exit(0)

#get input
if len(sys.argv) == 2:
	uSrc = sys.argv[1]
	uBorderWidth = 10
elif len(sys.argv) == 3:
	uSrc = sys.argv[1]
	uBorderWidth = int(sys.argv[2])
else:
	uSrc = input("Enter image name (without extension):")
	uBorderWidth = 10
#get source image
try:
	imgSrc = Image.open(uSrc + ".png")
except Exception:
	try:
		imgSrc = Image.open(uSrc + ".tga")
	except Exception:
		try:
			imgSrc = Image.open(uSrc + ".webp")
		except Exception:
			print("could not find valid file")
			exit(0)
#test image size
if imgSrc.size == (122,96):
	pass
elif imgSrc.size == (128,256):
	imgSrc = ImageOps.crop(imgSrc, (3,13,3,147))
else:
	print("invalid image size for HUD icons\nCorrect input image size is either 122x96 or 128x256")
	exit(0)
#create A
imgOut = Image.new(mode = "RGBA", size = (128,256), color = (0,0,0,0))
ImageDraw.Draw(imgOut).rectangle([(0,10),(127,169)], fill=(255,255,255,105), outline=None)
imgOut.paste(imgSrc, (3,13))
imgOut.save(f"HUD-{uSrc}-A.png", "PNG")
#create D
imgOut = Image.new(mode = "RGBA", size = (128,256), color = (0,0,0,0))
ImageDraw.Draw(imgOut).rectangle([(0,10),(127,169)], fill=(255,255,255,46), outline=None)
imgOut.paste(imgSrc, (3,13))
imgSrcInner = ImageOps.grayscale(imgSrc)
imgSrcInner = ImageOps.crop(imgSrcInner, (uBorderWidth,uBorderWidth,uBorderWidth,uBorderWidth))
imgOut.paste(imgSrcInner, (uBorderWidth + 3,uBorderWidth + 13))
imgOut.save(f"HUD-{uSrc}-D.png", "PNG")
#create R
imgOut = Image.new(mode = "RGBA", size = (128,256), color = (0,0,0,0))
ImageDraw.Draw(imgOut).rectangle([(0,10),(127,169)], fill=(255,255,255,105), outline=None)
imgSrcInner = ImageEnhance.Contrast(imgSrc).enhance(1.0)
imgSrcInner = ImageEnhance.Brightness(imgSrcInner).enhance(1.35)
imgOut.paste(imgSrcInner, (3,13))
imgOut.save(f"HUD-{uSrc}-R.png", "PNG")
#create S
imgOut = Image.new(mode = "RGBA", size = (128,256), color = (0,0,0,0))
ImageDraw.Draw(imgOut).rectangle([(0,10),(127,169)], fill=(255,255,255,255), outline=None)
imgSrcInner = ImageEnhance.Contrast(imgSrc).enhance(1.0)
imgSrcInner = ImageEnhance.Brightness(imgSrcInner).enhance(1.8)
imgOut.paste(imgSrcInner, (3,13))
imgOut.save(f"HUD-{uSrc}-S.png", "PNG")