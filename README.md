# EminenceBlue - Blue Dark theme for E

This is a dark theme with blue icons and some blue highlights, based on the [Eminence theme from Obsidion-StudionInc](https://github.com/Obsidian-StudiosInc/eminence/releases). It is 
meant to be easy on the eyes, and ideally light weight. This theme is a 
work in progress.

Eminence is created via a bash script and some modified edc files to 
convert default Enlightenment and Terminology themes from blue to 
Purple. The script will unpack the default theme, process the edc and 
png files. Then repack the theme as eminence. After it will clean up 
after itself leaving just the script. The resulting eminence.edj is 
placed is your home elementary and terminology themes directory.

The modified edc files are based on work
[from Matthias Wauer/@LeBlue](https://github.com/LeBlue) on the
[Enlightenment Arc theme](https://github.com/LeBlue/enlightenment-arc-theme).
The colors and eventually the reset will deviate heavily from the 
Enlightenment Arc theme, and Arc themes in general.

This theme has evolved to more than just color modifications to the 
default theme. It will be a semi hybrid between the default theme, Arc, 
and personal preferences.

See [releases](https://github.com/nathanrvance/eminence-blue/releases) 
to download themes.

![A screenshot of Eminence Theme](https://user-images.githubusercontent.com/10491434/82689655-d8e91400-9c28-11ea-898a-68c5adc4b1ac.jpg)

## Building
For the time being you will need to copy the
[assets directory](https://github.com/LeBlue/enlightenment-arc-theme/tree/master/assets),
at minimum the assets/other and assets/whitened folders, into the root 
folder next to eminence script and src dirs. They assets are in the 
process of being replaced/removed. Binaries will not be committed to 
this repo!

Without such the script/build will fail! You can refer to the 
.travis.yml for build enviroment preparations.

To build all, use -e/--elementary or -t/--terminology for just that theme.
```
chmod 775 eminence.sh
./eminence.sh

```

If you use the -i/install option resulting files will be placed in the 
following locations.

```
~/.elementary/themes/eminence.edj
~/.config/terminology/themes/eminence.edj
```

## Icons
There will never be binary images in this repositor. However any good 
theme needs custom icons. The plan for custom icons is to have them 
generated via either scripts or SVG files. SVG files will be coverted to 
rasters via ImageMagick. Scripts to generate images should also be using 
ImageMagick for such. This way all icons can be generated as needed with 
the source to their creation stored in editable files in git.

## Font
This theme is set to use Noto Sans font by default. You can change that 
via a Custom Font Class in Settings -> Font. It is recommend to ensure  
you have the font installed prior to use the them. Though it should fall 
back to some Sans, or some other font from fontconfig. All fonts should 
scale with changing font size, but some are not. Those that do not seem 
to adjust size with the default them. Which means that is an issue 
specific to this theme, and related.
