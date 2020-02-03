#!/bin/sh

## Information
## http://carlo-hamalainen.net/blog/2007/12/11/installing-minion-pro-fonts/
## http://www.ctan.org/tex-archive/fonts/mnsymbol/
## https://www.ctan.org/tex-archive/fonts/minionpro/

## 0.1: Install LCDF Typetools
## http://www.lcdf.org/type/
## Or if you use Homebrew (http://mxcl.github.com/homebrew/), 
## then uncomment: 
# brew install lcdf-typetools 

## 0.2: If ~/tmp doesn't exist, create it.
mkdir ~/tmp

## Destination. 
## Healy's script says the following: 
##   System wide is best in recent MacTeX releases:
DEST=`kpsexpand '$TEXMFLOCAL'`
## But this did not work for me (Mike Decrescenzo). 
## I inferred that TinyTex did not install kpsexpand.
## (At least... _I_ couldn't find it, but I'm not very smart.)
## Nonetheless upon digging through the TinyTex guts,
## it appeared that this would be an appropriate substitute.
## DEST=/users/$(whoami)/Library/TinyTeX/texmf-dist


## Downloader:
DOWNLOAD="curl -L -O"

## Directories where minion fonts may be found:
##   I (Mike) preferred to copy the fonts from the App contents dir below
##   to ~/Library/Fonts, hence the uncommented choice below.

#MINIONSRC=/Applications/Adobe\ Reader.app/Contents/Resources/Resource/Font/
#MINIONSRC=~/tmp/minionsrc
MINIONSRC=~/Library/Fonts




## Everything gets done in a temporary directory
cd ~/tmp

## 1: MnSymbol
## http://www.ctan.org/tex-archive/fonts/mnsymbol/
$DOWNLOAD http://mirror.ctan.org/fonts/mnsymbol.zip 

unzip mnsymbol
cd mnsymbol/tex

## Generates MnSymbol.sty
latex MnSymbol.ins

mkdir -p $DEST/tex/latex/MnSymbol/      \
    $DEST/fonts/source/public/MnSymbol/ \
    $DEST/doc/latex/MnSymbol/

cp MnSymbol.sty $DEST/tex/latex/MnSymbol/MnSymbol.sty
cd .. # we were in mnsymbol/tex
cp source/* $DEST/fonts/source/public/MnSymbol/
cp MnSymbol.pdf README $DEST/doc/latex/MnSymbol/

mkdir -p $DEST/fonts/map/dvips/MnSymbol \
    $DEST/fonts/enc/dvips/MnSymbol      \
    $DEST/fonts/type1/public/MnSymbol   \
    $DEST/fonts/tfm/public/MnSymbol 
cp enc/MnSymbol.map $DEST/fonts/map/dvips/MnSymbol/
cp enc/*.enc $DEST/fonts/enc/dvips/MnSymbol/
cp pfb/*.pfb $DEST/fonts/type1/public/MnSymbol/
cp tfm/* $DEST/fonts/tfm/public/MnSymbol/

## Not strictly needed if DEST is in the home
## tree on OSX (~/Library ...), but will be needed otherwise
sudo mktexlsr
sudo updmap -sys --enable MixedMap MnSymbol.map

# test
$DOWNLOAD https://s3.amazonaws.com/carlo-hamalainen.net/oldblog/stuff/myfiles/minionpro/mnsymbol-test.tex
pdflatex mnsymbol-test.tex


## 2: MinionPro
mkdir -p ~/tmp/minionpro
cd ~/tmp/minionpro

$DOWNLOAD http://mirrors.ctan.org/fonts/minionpro/enc-2.000.zip
$DOWNLOAD http://mirrors.ctan.org/fonts/minionpro/metrics-base.zip
$DOWNLOAD http://mirrors.ctan.org/fonts/minionpro/metrics-full.zip
$DOWNLOAD http://mirrors.ctan.org/fonts/minionpro/scripts.zip

## This will make the otf directory, among other things.
unzip scripts.zip

cp $MINIONSRC/Minion*otf otf/

## Generate the pfb files
## This step requires that the LCDF type tools are installed.  
## Get them here: http://www.lcdf.org/type/
./convert.sh

## Copy the pfb files to where they belong:
mkdir -p $DEST/fonts/type1/adobe/MinionPro
cp pfb/*.pfb $DEST/fonts/type1/adobe/MinionPro

SRC=`pwd`
cd $DEST
unzip $SRC/enc-2.000.zip
unzip $SRC/metrics-base.zip
unzip $SRC/metrics-full.zip
cd $SRC

## Not strictly needed if DEST is in the home
## tree on OSX (~/Library ...), but will be needed otherwise

sudo mktexlsr
sudo updmap -sys --enable MixedMap MinionPro.map


## Test:
$DOWNLOAD https://s3.amazonaws.com/carlo-hamalainen.net/oldblog/stuff/myfiles/minionpro/minionpro-test.tex
pdflatex minionpro-test.tex
