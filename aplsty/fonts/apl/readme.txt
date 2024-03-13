Thank you for your letter of 27 February. The original purpose
of our APL font and macros was to solve the immediate problem
of writing documents with APL code. Therefore, they are free for
anyone who finds them useful. Some people have requested the font
and we have sent them the files appended below (with CMAPL10 and
two conversion programs for downloading pixel files, not given here).
Further, we have nothing against giving our net address to the
users because it would be useful to hear about extensions made
to the system.

The files APLDEF.TEX and TUGBOAT.TEX are identical with the second
versions sent to you (via BITNET) except for minimal changes (there
are some corrections and extensions in APLDEF.TEX, and in
TUGBOAT.TEX one APL line was corrected.) We think the files are
in a "final" form (at least we are not planning any changes).

Our original purpose was to publish the second version, but the only
difference was really the removal of the tilde space character (this
resulted in more complex 1-character macros, but the user cannot
see any difference; moreover, TeX runs only about 14% slower). Thus,
we feel that there is no reason to publish a list of errata in
TUGboat, because any user would inevitably have to use the new
version (the old one has not been released).

We are adding a file containing sample examples on the use of the
APL mnemonics.

Aarno Hohti



%=================================================================
%                     R E A D M E . T X T
%=================================================================

      These files contain the necessary material for producing
APL documents with TeX.  It should be pointed out that as written
in an article published in TUGboat, the system as such can be
described as a straightforward solution to the problem of making
nice documents containing APL code.  Instead of trying to achieve
a completed result, we tell the reader how to use existing MetaFont
character descriptions as far as possible to provide an APL font
of reasonably fine quality.  Further development is left to the users. 
Combined with suitable TeX macros using Digital's mnemonics -- chosen
because of the popularity of the interpreter among APL users
(it is really the only one used at our site) -- the font can be used
smoothly enough.  Furthermore, if combined with an APL workspace
providing functions for an automatic conversion of APL workspaces
into TeX code, the system can be used to merge pre-existing
APL code into documents without the pain of re-writing the code
in Digital's 2-letter mnemonics. 
      To produce pixel files from the MetaFont file CMAPL10.MF,
you have to run MetaFont in your local machine.  By typing METAFONT
you should get the prompt symbol '*'.  It may be necessary to use
the form

            METAFONT\INPUT_DIRECTORY = XXXXXX

where XXXXXX is the global name of the directory where the basic
CMMF definitions can be found.
The following discussion will then get MetaFont to produce a generic
font file CMAPL10.360GF:

                 * \relax;
                 * \mode = imagen;
                 * \mag = 1.2;
                 * input cmapl10

Here \mode = imagen was used to get a pixel file for a laserprinter
with the resolution 200 times 200 pixels per square inch.  It is
possible that the definition of 'imagen' is different at your local
site; in the case of error ask the person who installed your local
MetaFont.  Notice that \mag = 1.2 is needed in case you want to get
magnified pixels.  The final pixel (because of the resolution 200)
files will then be named CMAPL10.1800PXL (or whatever you choose
to call them).  If you want to produce 'small' pixel files for example
for a screen previewer, use \mag = xxx with an appropriate constant xxx.
(You can check the form of characters obtained on a teletype terminal
by using the program GFTYPE.)  Finally, you get a pixel file from
CMAPL10.xxxGF by running the program GF(TO)PXL.EXE, which should be
found together with MetaFont.
        Some people want to use their pixel files on a PC (the
laserprinter is connected to a PC or for previewing purposes).  In
that case the pixel files must be downloaded from the host.  We never
use programs like Kermit for transferring the binary file but
first convert it to hex form, load the file down as a text file and
then convert it back.  It is IMPORTANT to notice that pixel files in
VAXes (say) are composed of 512 byte blocks.  The pixel file itself
is ended by the pixel_id, which is either 1001 (rasters are in word packed
form) or 1002 (rasters are in byte packed form).  Some programs running
on PCs assume that the last 4 bytes of the pixel file really
represent the pixel_id.  Hence, the pixel files downloaded from the host
should be CLEANed from garbage (the programs CONVERT and CLEAN are
given for convenience and to fix the definition of what they should do).
       MetaFont also produces the file CMAPL10.TFM containing the
metric information of the characters in the font.  These are needed
by TeX, and they can be downloaded as such (at least if you are
using Micro-TeX or PCTeX).

        In order to use the mnemonics, the macros in APLSTYLE are
needed.  There are basically two ways of merging APL code.  There are
standard macros called VERBATIM, which enable the user to produce
'typewriter-like' output.  As APL is modelled on a typewriter style,
too, it has been reasonable to extend VERBATIM to accept different
typewriter-like fonts.  The escape sequence \choosett enables you to
choose the font you want to use.  Thus, \choosett{tentt} swithces
the standard font CMTT10 on, whereas \choosett{apl} chooses the font
APL, defined in APLSTYLE by '\font\apl = cmapl10'.  First, you can
insert APL code into text lines.  In this case you can call any
APL symbol either by its 2-letter mnemonic (for example \BX produces the
box symbol) if there is no symbol for it OR otherwise by its name
surrounded by two @'s.  (The @ character swithces into the current
typewriter style.)  Thus, @A_B@ produces 'A <-- B' in APL style, because
'_' is the name of '<--' in Digital's mnemonics.  Secondly, you can
insert APL code in 'screenlike' mode.  The code is to be delimited
by the pair \begintt - \endtt.  Example:

\begintt
    @DL Z_ZNPLUS N;@BXIO    % Here '@' replaces '\' as the escape
[1]   @BXIO_0               % character
[2]   Z_N@AB(@ION)@SO.+@ION
    @DL
\endtt

Please note that in this case the material between \begintt -- \endtt
is considered by TeX as a vertical box that cannot be divided between
pages.  Thus, if you have a long APL function, it might produce
a message of underfull vbox.

