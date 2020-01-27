# Set Up Minion Fonts with TinyTeX

This repository contains scripts to set up Minion Pro and MnSymbol for pdflatex _as installed from [TinyTeX](https://yihui.org/tinytex/)_. It barely modifies the guides by [Kieran Healy](https://kieranhealy.org/blog/archives/2012/11/10/installing-minion-pro/) and by [Carlo Hämäläinen's](https://carlo-hamalainen.net/2007/12/11/installing-minion-pro-fonts/), which weren't working out-of-the-box with the TinyTeX setup.^[
  What's different? The original routine relied on commands and environmental variables that (at least for me) were not installed/defined with TinyTeX. So I found a workaround. You can view the critical changes [here](https://github.com/mikedecr/setup-minion-fonts/commit/df2a48c5a858a3606aab52bd40a6045444c94712). I also updated URLs to Hämäläinen's test files.
]

The `reference` folder contains Healy's version, for posterity.


## How to

The script `setup-minion.sh` walks through the setup, but the overview is like so:

1. You need Minion Pro, which you can get by installing [Adobe Acrobat Reader](https://get.adobe.com/reader/).
2. LCDF TypeTools [here](http://www.lcdf.org/type/) or use (`brew install lcdf-typetools `).
3. (Optional) Copy Minion Pro from the Acrobat support directory to your system fonts
4. Follow the script

