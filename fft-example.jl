# FFT example

import Pkg
installed = Pkg.installed()
required = ["Images", "Images", "ImageView", "FFTW"]

# check
if  ( issubset(required, keys(installed) ) )
    println("not all packages are installed. check!")
    println("need $required !")
    Pkg.add("Images")
    Pkg.add("ImageView")
    Pkg.add("Plots")
    Pkg.add("FFTW")
end

# you may have to install
# import Pkg
# Pkg.add("Images")
# Pkg.add("ImageView")
# Pkg.add("Plots")
# Pkg.add("FFTW")

using FFTW
using Images
using ImageView

# make a gabor
nPixels = 512;

# for x/y grid
r = range(-3π, 3π, length = nPixels)
sigma = 3.1;
lambda = 1.2;
theta = π ./ 3;

# list comprehension to create image
# [  (expr of x and y)  FOR x in r, y in r ]
X = [ sin(lambda .* (x.*cos(theta) + y.*sin(theta))) .* exp(-(x.^2+y.^2)/sigma) for x in r, y in r ]

# display
imshow(X)

# FFT and shifting...
Xf = fftshift( fft(X) );

# show mag and phase of FFT
imshow( abs.(Xf));
imshow( angle.(Xf));
