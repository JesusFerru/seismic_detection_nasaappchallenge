%%
%% This is file `cdaref.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% merlin.mbs  (with options: `No included files. babel,seq-no,nm-init,ed-au,mct-3,mct-x3,yr-par,xmth,tit-it,jttl-rm,thtit-a,vol-bf,vnum-sp,volp-com,jpg-1,num-xser,jnm-x,pub-date,pre-pub,edpar,edby,blk-com,ppx,ed,abr,ednx,xedn,varand,and-xcom,etal-xc,nfss,')
%% ----------------------------------------
%% *** Estilo de bibliografia para os Cadernos de Astronomia ***
%% 
%% Copyright 1994-2011 Patrick W Daly
 % ===============================================================
 % IMPORTANT NOTICE:
 % This bibliographic style (bst) file has been generated from one or
 % more master bibliographic style (mbs) files, listed above.
 %
 % This generated file can be redistributed and/or modified under the terms
 % of the LaTeX Project Public License Distributed from CTAN
 % archives in directory macros/latex/base/lppl.txt; either
 % version 1 of the License, or any later version.
 % ===============================================================
 % Name and version information of the main mbs file:
 % \ProvidesFile{merlin.mbs}[2011/11/18 4.33 (PWD, AO, DPC)]
 %   For use with BibTeX version 0.99a or later
 %-------------------------------------------------------------------
 % This bibliography style file is intended for texts in ENGLISH
 % This is a numerical citation style, and as such is standard LaTeX.
 % It requires no extra package to interface to the main text.
 % The form of the \bibitem entries is
 %   \bibitem{key}...
 % Usage of \cite is as follows:
 %   \cite{key} ==>>          [#]
 %   \cite[chap. 2]{key} ==>> [#, chap. 2]
 % where # is a number determined by the ordering in the reference list.
 % The order in the reference list is that by which the works were originally
 %   cited in the text, or that in the database.
 %---------------------------------------------------------------------

 ENTRY
 { address
   author
   booktitle
   chapter
   edition
   editor
   eid
   howpublished
   institution
   journal
   key
   month
   note
   number
   organization
   pages
   publisher
   school
   series
   title
   type
   volume
   year
   eprint % urlbst
   doi % urlbst
   pubmed % urlbst
   url % urlbst
   lastchecked % urlbst
 }
 {}
 { label }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }

% urlbst...
% urlbst constants and state variables
STRINGS { urlintro
 eprinturl eprintprefix doiprefix doiurl pubmedprefix pubmedurl
 citedstring onlinestring linktextstring
 openinlinelink closeinlinelink }
INTEGERS { hrefform doiform inlinelinks makeinlinelink
 addeprints adddoi addpubmedresolver isyear }   %PPGCosmoN: declares new variable: isyear
FUNCTION {init.urlbst.variables}
{
 % The following constants may be adjusted by hand, if desired

 % The first set allow you to enable or disable certain functionality.
 #1 'addeprints :=         % 0=no eprints; 1=include eprints
 #0 'adddoi :=     % 0=no DOI resolver; 1=include it     
 #0 'addpubmedresolver :=     % 0=no PUBMED resolver; 1=include it                % PPGCosmoN: changed from 1 to 0.
 #2 'hrefform :=           % 0=no crossrefs; 1=hypertex xrefs; 2=hyperref refs
 #0 'doiform :=	% 0=with href; 1=with \doi{}
 #0 'inlinelinks :=        % 0=URLs explicit; 1=URLs attached to titles

 % String constants, which you _might_ want to tweak.
 "Disponível em " 'urlintro := % prefix before URL; typically "Available from:" or "URL":
 "online" 'onlinestring := % indication that resource is online; typically "online"
 "acesso em " 'citedstring := % indicator of citation date; typically "cited "
 "[link]" 'linktextstring := % dummy link text; typically "[link]"
 "http://arxiv.org/abs/" 'eprinturl := % prefix to make URL from eprint ref
 "ArXiv:" 'eprintprefix := % text prefix printed before eprint ref; typically "arXiv:"
 "https://doi.org/" 'doiurl := % prefix to make URL from DOI
 "doi:" 'doiprefix :=      % text prefix printed before DOI ref; typically "doi:"
 "http://www.ncbi.nlm.nih.gov/pubmed/" 'pubmedurl := % prefix to make URL from PUBMED
 "PMID:" 'pubmedprefix :=      % text prefix printed before PUBMED ref; typically "PMID:"

 % The following are internal state variables, not configuration constants,
 % so they shouldn't be fiddled with.
 #0 'makeinlinelink :=     % state variable managed by possibly.setup.inlinelink
 "" 'openinlinelink :=     % ditto
 "" 'closeinlinelink :=    % ditto
 }
INTEGERS {
 bracket.state
 outside.brackets
 open.brackets
 within.brackets
 close.brackets
}
% ...urlbst to here

FUNCTION {init.state.consts}
{ #0 'outside.brackets := % urlbst...
 #1 'open.brackets :=
 #2 'within.brackets :=
 #3 'close.brackets := % ...urlbst to here
 
 #0 'before.all :=
 #1 'mid.sentence :=
 #2 'after.sentence :=
 #3 'after.block :=
}
STRINGS { s t}

% urlbst

FUNCTION {output.nonnull.original}
{ 's :=
 output.state mid.sentence =
   { ", " * write$ }
   { output.state after.block =
       { add.period$ write$
         newline$
         "\newblock " write$
       }
       { output.state before.all =
           'write$
           { add.period$ " " * write$ }
         if$
       }
     if$
     mid.sentence 'output.state :=
   }
 if$
 s
}


% urlbst...
% The following three functions are for handling inlinelink.  They wrap
% a block of text which is potentially output with write$ by multiple
% other functions, so we don't know the content a priori.
% They communicate between each other using the variables makeinlinelink
% (which is true if a link should be made), and closeinlinelink (which holds
% the string which should close any current link.  They can be called
% at any time, but start.inlinelink will be a no-op unless something has
% previously set makeinlinelink true, and the two ...end.inlinelink functions
% will only do their stuff if start.inlinelink has previously set
% closeinlinelink to be non-empty.
% (thanks to 'ijvm' for suggested code here)
FUNCTION {uand}
{ 'skip$ { pop$ #0 } if$ } % 'and' (which isn't defined at this point in the file)
FUNCTION {possibly.setup.inlinelink}
{ makeinlinelink hrefform #0 > uand
   { doi empty$ adddoi uand
       { pubmed empty$ addpubmedresolver uand
           { eprint empty$ addeprints uand
               { url empty$
                   { "" }
                   { url }
                 if$ }
               { eprinturl eprint * }
             if$ }
           { pubmedurl pubmed * }
         if$ }
%        { doiurl doi * }
        { doi empty$
           { "XXX" }
           { doiurl doi * }
         if$
       }
     if$
     % an appropriately-formatted URL is now on the stack
     hrefform #1 = % hypertex
       { "\special {html:<a href=" quote$ * swap$ * quote$ * "> }{" * 'openinlinelink :=
         "\special {html:</a>}" 'closeinlinelink := }
       { "\href{" swap$ * "} {" * 'openinlinelink := % hrefform=#2 -- hyperref  %PPGCosmoN: inserted the hypersetup. %cdaref removed
         % the space between "} {" matters: a URL of just the right length can cause "\% newline em"
         "}" 'closeinlinelink := }                                                                              %PPGCosmoN: put a second } to close hypersetup. %cdaref removed
     if$
     #0 'makeinlinelink :=
     }
   'skip$
 if$ % makeinlinelink
}
FUNCTION {add.inlinelink}
{ openinlinelink empty$
   'skip$
   { openinlinelink swap$ * closeinlinelink *
     "" 'openinlinelink :=
     }
 if$
}


FUNCTION {output.nonnull}
{ % Save the thing we've been asked to output
 's :=
 % If the bracket-state is close.brackets, then add a close-bracket to
 % what is currently at the top of the stack, and set bracket.state
 % to outside.brackets
 bracket.state close.brackets =
   { "]" *
     outside.brackets 'bracket.state :=
   }
   'skip$
 if$
 bracket.state outside.brackets =
   { % We're outside all brackets -- this is the normal situation.
     % Write out what's currently at the top of the stack, using the
     % original output.nonnull function.
     s
     add.inlinelink
     output.nonnull.original % invoke the original output.nonnull
   }
   { % Still in brackets.  Add open-bracket or (continuation) comma, add the
     % new text (in s) to the top of the stack, and move to the close-brackets
     % state, ready for next time (unless inbrackets resets it).  If we come
     % into this branch, then output.state is carefully undisturbed.
     bracket.state open.brackets =
       { " [" * }
       { ", " * } % bracket.state will be within.brackets
     if$
     s *
     close.brackets 'bracket.state :=
   }
 if$
}
% Call this function just before adding something which should be presented in
% brackets.  bracket.state is handled specially within output.nonnull.
FUNCTION {inbrackets}
{ bracket.state close.brackets =
   { within.brackets 'bracket.state := } % reset the state: not open nor closed
   { open.brackets 'bracket.state := }
 if$
}

FUNCTION {format.lastchecked}
{ lastchecked empty$
   { "" }
   { citedstring lastchecked * }
 if$
}
% ...urlbst to here

FUNCTION {output}
{ duplicate$ empty$
   'pop$
   'output.nonnull
 if$
}
FUNCTION {output.check}
{ 't :=
 duplicate$ empty$
   { pop$ "empty " t * " in " * cite$ * warning$ }
   'output.nonnull
 if$
}

FUNCTION {output.bibitem.original} % urlbst (renamed from output.bibitem, so it can be wrapped below)
{ newline$
 "\bibitem{" write$
 cite$ write$
 "}" write$
 newline$
 ""
 before.all 'output.state :=
}

FUNCTION {fin.entry.original} % urlbst (renamed from fin.entry, so it can be wrapped below)
{ add.period$
 write$
 newline$
}

FUNCTION {new.block}
{ output.state before.all =
   'skip$
   { after.block 'output.state := }
 if$
}
FUNCTION {new.sentence}
{ output.state after.block =
   'skip$
   { output.state before.all =
       'skip$
       { after.sentence 'output.state := }
     if$
   }
 if$
}
FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}

FUNCTION {date.block}
{
 skip$
}

FUNCTION {not}
{   { #0 }
   { #1 }
 if$
}
FUNCTION {and}
{   'skip$
   { pop$ #0 }
 if$
}
FUNCTION {or}
{   { pop$ #1 }
   'skip$
 if$
}
FUNCTION {new.block.checka}
{ empty$
   'skip$
   'new.block
 if$
}
FUNCTION {new.block.checkb}
{ empty$
 swap$ empty$
 and
   'skip$
   'new.block
 if$
}
FUNCTION {new.sentence.checka}
{ empty$
   'skip$
   'new.sentence
 if$
}
FUNCTION {new.sentence.checkb}
{ empty$
 swap$ empty$
 and
   'skip$
   'new.sentence
 if$
}
FUNCTION {field.or.null}
{ duplicate$ empty$
   { pop$ "" }
   'skip$
 if$
}
FUNCTION {emphasize}
{ duplicate$ empty$
   { pop$ "" }
   { "\emph{" swap$ * "}" * }
 if$
}
FUNCTION {bolden}
{ duplicate$ empty$
   { pop$ "" }
   { "\textbf{" swap$ * "}" * }
 if$
}
FUNCTION {tie.or.space.prefix}
{ duplicate$ text.length$ #3 <
   { "~" }
   { " " }
 if$
 swap$
}

FUNCTION {capitalize}
{ "u" change.case$ "t" change.case$ }

FUNCTION {space.word}
{ " " swap$ * " " * }
% Here are the language-specific definitions for explicit words.
% Each function has a name bbl.xxx where xxx is the English word.
% The language selected here is ENGLISH
FUNCTION {bbl.and}
{ "\protect\BIBand{}"}

FUNCTION {bbl.etal}
{ "et~al." }

FUNCTION {bbl.editors}
{ "eds." }

FUNCTION {bbl.editor}
{ "ed." }

FUNCTION {bbl.edby}
{ "editado por" }

FUNCTION {bbl.edition}
{ "ed." }

FUNCTION {bbl.volume}
{ "vol." }

FUNCTION {bbl.of}
{ "de" }

FUNCTION {bbl.number}
{ "no." }

FUNCTION {bbl.nr}
{ "no." }

FUNCTION {bbl.in}
{ "in" }

FUNCTION {bbl.pages}
{ "" }

FUNCTION {bbl.page}
{ "" }

FUNCTION {bbl.chapter}
{ "cap." }

FUNCTION {bbl.techrep}
{ "Tech. Rep." }

FUNCTION {bbl.mthesis}
{ "Dissertação de Mestrado" }

FUNCTION {bbl.phdthesis}
{ "Tese de Doutorado" }

MACRO {jan} {"Jan."}

MACRO {feb} {"Feb."}

MACRO {mar} {"Mar."}

MACRO {apr} {"Apr."}

MACRO {may} {"May"}

MACRO {jun} {"Jun."}

MACRO {jul} {"Jul."}

MACRO {aug} {"Aug."}

MACRO {sep} {"Sep."}

MACRO {oct} {"Oct."}

MACRO {nov} {"Nov."}

MACRO {dec} {"Dec."}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
{"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

FUNCTION {bibinfo.check}
{ swap$
 duplicate$ missing$
   {
     pop$ pop$
     ""
   }
   { duplicate$ empty$
       {
         swap$ pop$
       }
       { swap$
         pop$
       }
     if$
   }
 if$
}
FUNCTION {bibinfo.warn}
{ swap$
 duplicate$ missing$
   {
     swap$ "missing " swap$ * " in " * cite$ * warning$ pop$
     ""
   }
   { duplicate$ empty$
       {
         swap$ "empty " swap$ * " in " * cite$ * warning$
       }
       { swap$
         pop$
       }
     if$
   }
 if$
}
INTEGERS { nameptr namesleft numnames }


STRINGS  { bibinfo}

FUNCTION {format.names}
{ 'bibinfo :=
 duplicate$ empty$ 'skip$ {
 's :=
 "" 't :=
 #1 'nameptr :=
 s num.names$ 'numnames :=
 numnames 'namesleft :=
   { namesleft #0 > }
   { s nameptr
     "{f.~}{vv~}{ll}{, jj}"
     format.name$
     bibinfo bibinfo.check
     't :=
     nameptr #1 >
       {
         nameptr #2 =			         
         numnames #3 		% Change here numnames from #3 to #2 if et al. should come up for any reference with more than 2 authors
         > and
           { "others" 't :=
             #1 'namesleft := }
           'skip$
         if$
         namesleft #1 >
           { ", " * t * }
           {
             s nameptr "{ll}" format.name$ duplicate$ "others" =
               { 't := }
               { pop$ }
             if$
             t "others" =
               {
                 " " * bbl.etal *
               }
               {
                 numnames #3 >
                   { "," * }
                   'skip$
                 if$
                 bbl.and
                 space.word * t *
               }
             if$
           }
         if$
       }
       't
     if$
     nameptr #1 + 'nameptr :=
     namesleft #1 - 'namesleft :=
   }
 while$
 } if$
}
FUNCTION {format.names.ed}
{
 format.names
}
FUNCTION {format.authors}
{ author "author" format.names
}
FUNCTION {get.bbl.editor}
{ editor num.names$ #1 > 'bbl.editors 'bbl.editor if$ }

FUNCTION {format.editors}
{ editor "editor" format.names duplicate$ empty$ 'skip$
   {
     " " *
     get.bbl.editor
  "(" swap$ * ")" *
     *
   }
 if$
}
FUNCTION {format.note}
{
note empty$
   { "" }
   { note #1 #1 substring$
     duplicate$ "{" =
       'skip$
       { output.state mid.sentence =
         { "l" }
         { "u" }
       if$
       change.case$
       }
     if$
     note #2 global.max$ substring$ * "note" bibinfo.check
   }
 if$
}

FUNCTION {format.title}
{ title
 duplicate$ empty$ 'skip$
   { "t" change.case$ }
 if$
 "title" bibinfo.check
 duplicate$ empty$ 'skip$
   {
     emphasize
   }
 if$
}
FUNCTION {output.bibitem}
{ newline$
 "\bibitem{" write$
 cite$ write$
 "}" write$
 newline$
 ""
 before.all 'output.state :=
}

FUNCTION {n.dashify}
{
 't :=
 ""
   { t empty$ not }
   { t #1 #1 substring$ "-" =
       { t #1 #2 substring$ "--" = not
           { "--" *
             t #2 global.max$ substring$ 't :=
           }
           {   { t #1 #1 substring$ "-" = }
               { "-" *
                 t #2 global.max$ substring$ 't :=
               }
             while$
           }
         if$
       }
       { t #1 #1 substring$ *
         t #2 global.max$ substring$ 't :=
       }
     if$
   }
 while$
}

FUNCTION {word.in}
{ bbl.in
 " " * }

FUNCTION {format.date}
{
 ""
 duplicate$ empty$
 year  "year"  bibinfo.check duplicate$ empty$
   { swap$ 'skip$
       { "there's a month but no year in " cite$ * warning$ }
     if$
     *
   }
   { swap$ 'skip$
       {
         swap$
         " " * swap$
       }
     if$
     *
   }
 if$
 duplicate$ empty$
   'skip$
   {
     before.all 'output.state :=
   " ~(" swap$ * ")" *
   }
 if$
}
FUNCTION {format.btitle}
{ title "title" bibinfo.check
 duplicate$ empty$ 'skip$
   {
     emphasize
   }
 if$
}
FUNCTION {either.or.check}
{ empty$
   'pop$
   { "can't use both " swap$ * " fields in " * cite$ * warning$ }
 if$
}
FUNCTION {format.bvolume}
{ volume empty$
   { "" }
   { bbl.volume volume tie.or.space.prefix
     "volume" bibinfo.check * *
     series "series" bibinfo.check
     duplicate$ empty$ 'pop$
       { swap$ bbl.of space.word * swap$
         emphasize * }
     if$
     "volume and number" number either.or.check
   }
 if$
}
FUNCTION {format.number.series}
{ volume empty$
   { number empty$
       { series field.or.null }
       { series empty$
           { number "number" bibinfo.check }
           { output.state mid.sentence =
               { bbl.number }
               { bbl.number capitalize }
             if$
             number tie.or.space.prefix "number" bibinfo.check * *
             bbl.in space.word *
             series "series" bibinfo.check *
           }
         if$
       }
     if$
   }
   { "" }
 if$
}

FUNCTION {format.edition}
{ edition duplicate$ empty$ 'skip$
   {
     output.state mid.sentence =
       { "l" }
       { "t" }
     if$ change.case$
     "edition" bibinfo.check
     " " * bbl.edition *
   }
 if$
}
INTEGERS { multiresult }
FUNCTION {multi.page.check}
{ 't :=
 #0 'multiresult :=
   { multiresult not
     t empty$ not
     and
   }
   { t #1 #1 substring$
     duplicate$ "-" =
     swap$ duplicate$ "," =
     swap$ "+" =
     or or
       { #1 'multiresult := }
       { t #2 global.max$ substring$ 't := }
     if$
   }
 while$
 multiresult
}
FUNCTION {format.pages}
{ pages duplicate$ empty$ 'skip$
   { duplicate$ multi.page.check
       {
         n.dashify
       }
       {
       }
     if$
     "pages" bibinfo.check
   }
 if$
}
FUNCTION {first.page}
{ 't :=
 ""
   {  t empty$ not t #1 #1 substring$ "-" = not and }
   { t #1 #1 substring$ *
     t #2 global.max$ substring$ 't :=
   }
 while$
}

FUNCTION {format.journal.pages}
{ pages duplicate$ empty$ 'pop$
   { swap$ duplicate$ empty$
       { pop$ pop$ format.pages }
       {
         ", " *
         swap$
         first.page
         "pages" bibinfo.check
         *
       }
     if$
   }
 if$
}
FUNCTION {format.journal.eid}
{ eid "eid" bibinfo.check
 duplicate$ empty$ 'pop$
   { swap$ duplicate$ empty$ 'skip$
     {
         ", " *
     }
     if$
     swap$ *
   }
 if$
}
FUNCTION {format.vol.num.pages}
{ volume field.or.null
 duplicate$ empty$ 'skip$
   {
     "volume" bibinfo.check
   }
 if$
 bolden
 number "number" bibinfo.check duplicate$ empty$ 'skip$
   {
     swap$ duplicate$ empty$
       { "there's a number but no volume in " cite$ * warning$ }
       'skip$
     if$
     swap$
     "(" swap$ * ")" *
   }
 if$ *
 eid empty$
   { format.journal.pages }
   { format.journal.eid }
 if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
   'format.pages
   { type empty$
       { bbl.chapter }
       { type "l" change.case$
         "type" bibinfo.check
       }
     if$
     chapter tie.or.space.prefix
     "chapter" bibinfo.check
     * *
     pages empty$
       'skip$
       { ", " * format.pages * }
     if$
   }
 if$
}

FUNCTION {format.booktitle}
{
 booktitle "booktitle" bibinfo.check
 emphasize
}
FUNCTION {format.in.ed.booktitle}
{ format.booktitle duplicate$ empty$ 'skip$
   {
     editor "editor" format.names.ed duplicate$ empty$ 'pop$
       {
         bbl.edby
         " " * swap$ *
         swap$
         "," *
         " " * swap$
         * }
     if$
     word.in swap$ *
   }
 if$
}
FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
 month empty$ year empty$ note empty$
 and and and and and
   { "all relevant fields are empty in " cite$ * warning$ }
   'skip$
 if$
}
FUNCTION {format.thesis.type}
{ type duplicate$ empty$
   'pop$
   { swap$ pop$
     "t" change.case$ "type" bibinfo.check
   }
 if$
}
FUNCTION {format.tr.number}
{ number "number" bibinfo.check
 type duplicate$ empty$
   { pop$ bbl.techrep }
   'skip$
 if$
 "type" bibinfo.check
 swap$ duplicate$ empty$
   { pop$ "t" change.case$ }
   { tie.or.space.prefix * * }
 if$
}
FUNCTION {format.article.crossref}
{
 key duplicate$ empty$
   { pop$
     journal duplicate$ empty$
       { "need key or journal for " cite$ * " to crossref " * crossref * warning$ }
       { "journal" bibinfo.check emphasize word.in swap$ * }
     if$
   }
   { word.in swap$ * " " *}
 if$
 " \cite{" * crossref * "}" *
}
FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
 "editor" bibinfo.check
 editor num.names$ duplicate$
 #2 >
   { pop$
     "editor" bibinfo.check
     " " * bbl.etal
     *
   }
   { #2 <
       'skip$
       { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
           {
             "editor" bibinfo.check
             " " * bbl.etal
             *
           }
           {
            bbl.and space.word
             * editor #2 "{vv~}{ll}" format.name$
             "editor" bibinfo.check
             *
           }
         if$
       }
     if$
   }
 if$
}
FUNCTION {format.book.crossref}
{ volume duplicate$ empty$
   { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
     pop$ word.in
   }
   { bbl.volume
     swap$ tie.or.space.prefix "volume" bibinfo.check * * bbl.of space.word *
   }
 if$
 editor empty$
 editor field.or.null author field.or.null =
 or
   { key empty$
       { series empty$
           { "need editor, key, or series for " cite$ * " to crossref " *
             crossref * warning$
             "" *
           }
           { series emphasize * }
         if$
       }
       { key * }
     if$
   }
   { format.crossref.editor * }
 if$
 " \cite{" * crossref * "}" *
}
FUNCTION {format.incoll.inproc.crossref}
{
 editor empty$
 editor field.or.null author field.or.null =
 or
   { key empty$
       { format.booktitle duplicate$ empty$
           { "need editor, key, or booktitle for " cite$ * " to crossref " *
             crossref * warning$
           }
           { word.in swap$ * }
         if$
       }
       { word.in key * " " *}
     if$
   }
   { word.in format.crossref.editor * " " *}
 if$
 " \cite{" * crossref * "}" *
}

% urlbst...
% Functions for making hypertext links.
% In all cases, the stack has (link-text href-url)
%
% make 'null' specials
FUNCTION {make.href.null}
{
 pop$
}
% make hypertex specials
FUNCTION {make.href.hypertex}
{
 "\special {html:<a href=" quote$ *
 swap$ * quote$ * "> }" * swap$ *
 "\special {html:</a>}" *
}

% make hyperref specials
FUNCTION {make.href.hyperref}
{
   "\href {" swap$ * "} {\path{" * swap$ * "}}" *
}

FUNCTION {make.href}
{ hrefform #2 =
   'make.href.hyperref      % hrefform = 2
   { hrefform #1 =
       'make.href.hypertex  % hrefform = 1
       'make.href.null      % hrefform = 0 (or anything else)
     if$
   }
 if$
}

% If inlinelinks is true, then format.url should be a no-op, since it's
% (a) redundant, and (b) could end up as a link-within-a-link.
FUNCTION {format.url}
{ inlinelinks #1 = url empty$ or
  { "" }
  { hrefform #1 =
      { % special case -- add HyperTeX specials
        urlintro "\url{" url * "}" * url make.href.hypertex * }
      { urlintro "\url{" * url * "}" * }
    if$
  }
 if$
}
FUNCTION {format.eprint}
{ eprint empty$
   { "" }
   { eprintprefix eprint * eprinturl eprint * make.href }
 if$
}

FUNCTION {format.doi}
{ doi empty$
   { "" }
   { doiprefix doi * doiurl doi * make.href }
 if$
}

FUNCTION {format.pubmed}
{ pubmed empty$
   { "" }
   { pubmedprefix pubmed * pubmedurl pubmed * make.href }
 if$
}

% Output a URL.  We can't use the more normal idiom (something like
% `format.url output'), because the `inbrackets' within
% format.lastchecked applies to everything between calls to `output',
% so that `format.url format.lastchecked * output' ends up with both
% the URL and the lastchecked in brackets.
FUNCTION {output.url}
{ url empty$
   'skip$
   { new.block
     format.url output
     format.lastchecked output
   }
 if$
}

FUNCTION {output.web.refs}
{
 new.block
 inlinelinks
   'skip$ % links were inline -- don't repeat them
   { % If the generated DOI will be the same as the URL,
     % then don't print the URL (thanks to Joseph Wright for this code,
     % at http://tex.stackexchange.com/questions/5660)
     adddoi
         doiurl doi empty$ { "X" } { doi } if$ * % DOI URL to be generated
         url empty$ { "Y" } { url } if$          % the URL, or "Y" if empty
         =                                       % are the strings equal?
         and
       'skip$
       { output.url }
     if$
     addeprints eprint empty$ not and
       { format.eprint output.nonnull }
       'skip$
     if$
     adddoi doi empty$ not and
       { format.doi output.nonnull }
       'skip$
     if$
     addpubmedresolver pubmed empty$ not and
       { format.pubmed output.nonnull }
       'skip$
     if$
   }
 if$
}

% Wrapper for output.bibitem.original.
% If the URL field is not empty, set makeinlinelink to be true,
% so that an inline link will be started at the next opportunity
FUNCTION {output.bibitem}
{ outside.brackets 'bracket.state :=
 output.bibitem.original
 inlinelinks url empty$ not doi empty$ not or pubmed empty$ not or eprint empty$ not or and
   { #1 'makeinlinelink := }
   { #0 'makeinlinelink := }
 if$
}

% Wrapper for fin.entry.original
FUNCTION {fin.entry}
{ output.web.refs  % urlbst
 makeinlinelink       % ooops, it appears we didn't have a title for inlinelink
   { possibly.setup.inlinelink % add some artificial link text here, as a fallback
     linktextstring output.nonnull }
   'skip$
 if$
 bracket.state close.brackets = % urlbst
   { "]" * }
   'skip$
 if$
 fin.entry.original
}

% Webpage entry type.
% Title and url fields required;
% author, note, year, month, and lastchecked fields optional
% See references
%   ISO 690-2 http://www.nlc-bnc.ca/iso/tc46sc9/standard/690-2e.htm
%   http://www.classroom.net/classroom/CitingNetResources.html
%   http://neal.ctstateu.edu/history/cite.html
%   http://www.cas.usf.edu/english/walker/mla.html
% for citation formats for web pages.
FUNCTION {webpage}
{ output.bibitem
 author empty$
   { editor empty$
       'skip$  % author and editor both optional
       { format.editors output.nonnull }
     if$
   }
   { editor empty$
       { format.authors output.nonnull }
       { "can't use both author and editor fields in " cite$ * warning$ }
     if$
   }
 if$
 new.block
 title empty$ 'skip$ 'possibly.setup.inlinelink if$
 format.title "title" output.check
 inbrackets onlinestring output
 new.block
 year empty$
   'skip$
 % We don't need to output the URL details ('lastchecked' and 'url'),
 % because fin.entry does that for us, using output.web.refs.  The only
 % reason we would want to put them here is if we were to decide that
 % they should go in front of the rather miscellaneous information in 'note'.
 new.block
 note output
 fin.entry
}
% ...urlbst to here


FUNCTION {format.org.or.pub}
{ 't :=
 ""
 year empty$
   { "empty year in " cite$ * warning$ }
   'skip$
 if$
 address empty$ t empty$ and
 year empty$ and
   'skip$
   {
     add.blank "(" *
     t empty$
       { address "address" bibinfo.check *
       }
       { t *
         address empty$
           'skip$
           { ", " * address "address" bibinfo.check * }
         if$
       }
     if$
     year empty$
       'skip$
       { t empty$ address empty$ and
           'skip$
           { ", " * }
         if$
         year "year" bibinfo.check
         *
       }
     if$
     ")" *
   }
 if$
}
FUNCTION {format.publisher.address}
{ publisher "publisher" bibinfo.warn format.org.or.pub
}

FUNCTION {format.organization.address}
{ organization "organization" bibinfo.check format.org.or.pub
}

FUNCTION {article}	
{ output.bibitem
 format.authors "author" output.check
  title empty$ 'skip$ 'possibly.setup.inlinelink if$              % urlbst
 format.title "title" output.check
 crossref missing$
 { doi missing$
   { journal emphasize "journal" output.check
     add.blank
     format.vol.num.pages output% urlbst
     format.date "year" output.check
   }
   { #1 'makeinlinelink :=       % PPGCosmoN added. Forces the use of inline link.
     possibly.setup.inlinelink journal "journal" output.check     % PPGCosmoN changed. The link is put on the journal name.
     add.blank     								    % cdaref added to remove coma after journal name.
     #1 'makeinlinelink := 							    % cdaref added. Forces the use of inline link.
     possibly.setup.inlinelink format.vol.num.pages output       % cdaref changed. Function added to make volume, number and pages as a link too.
     #1 'makeinlinelink := 							    % cdaref added. Forces the use of inline link.
     possibly.setup.inlinelink format.date "year" output.check  % cdaref changed. Function added to make date as a link too.
   }
  if$
   }
   { format.article.crossref output.nonnull
     format.pages output
   }
 if$
 format.note output
 fin.entry
}
FUNCTION {book}
{ output.bibitem
 author empty$
   { format.editors "author and editor" output.check
   }
   { format.authors output.nonnull
     crossref missing$
       { "author and editor" editor either.or.check }
       'skip$
     if$
   }
 if$
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 doi missing$
 { format.btitle "title" output.check }
 { #1 'makeinlinelink := 			% cdaref added. Forces the use of inline link.
     possibly.setup.inlinelink format.btitle "title" output.check }
  if$
 crossref missing$
   { format.bvolume output
     format.number.series output
     format.publisher.address output
   }
   {
     format.book.crossref output.nonnull
     format.date "year" output.check
   }
 if$
 format.edition output
 format.note output
 fin.entry
}
FUNCTION {booklet}
{ output.bibitem
 format.authors output
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.title "title" output.check
 howpublished "howpublished" bibinfo.check output
 address "address" bibinfo.check output
 format.date output
 format.note output
 fin.entry
}

FUNCTION {inbook}
{ output.bibitem
 author empty$
   { format.editors "author and editor" output.check
   }
   { format.authors output.nonnull
     crossref missing$
       { "author and editor" editor either.or.check }
       'skip$
     if$
   }
 if$
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.btitle "title" output.check
 crossref missing$
   {
     format.publisher.address output
     format.bvolume output
     format.chapter.pages "chapter and pages" output.check
     format.number.series output
   }
   {
     format.chapter.pages "chapter and pages" output.check
     format.book.crossref output.nonnull
     format.date "year" output.check
   }
 if$
 format.edition output
 format.note output
 fin.entry
}

FUNCTION {incollection}
{ output.bibitem
 format.authors "author" output.check
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.title "title" output.check
 crossref missing$
   { format.in.ed.booktitle "booktitle" output.check
     format.publisher.address output
     format.bvolume output
     format.number.series output
     format.chapter.pages output
     format.edition output
   }
   { format.incoll.inproc.crossref output.nonnull
     format.chapter.pages output
   }
 if$
 format.note output
 fin.entry
}
FUNCTION {inproceedings}
{ output.bibitem
 format.authors "author" output.check
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 doi missing$
 { format.btitle "title" output.check }
 { #1 'makeinlinelink := 							    % cdaref added. Forces the use of inline link.
     possibly.setup.inlinelink format.btitle "title" output.check }
 if$
 crossref missing$
   { format.in.ed.booktitle "booktitle" output.check
     publisher empty$
       { format.organization.address output }
       { organization "organization" bibinfo.check output
         format.publisher.address output
       }
     if$
     format.bvolume output
     format.number.series output
     format.pages output
   }
   { format.incoll.inproc.crossref output.nonnull
     format.pages output
   }
 if$
 format.note output
 fin.entry
}
FUNCTION {conference} { inproceedings }
FUNCTION {manual}
{ output.bibitem
 author empty$
   { organization "organization" bibinfo.check
     duplicate$ empty$ 'pop$
       { output
         address "address" bibinfo.check output
       }
     if$
   }
   { format.authors output.nonnull }
 if$
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.btitle "title" output.check
 author empty$
   { organization empty$
       {
         address "address" bibinfo.check output
       }
       'skip$
     if$
   }
   {
     organization "organization" bibinfo.check output
     address "address" bibinfo.check output
   }
 if$
 format.edition output
 format.date output
 format.note output
 fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
 format.authors "author" output.check
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.title
 "title" output.check
 bbl.mthesis format.thesis.type output.nonnull
 school "school" bibinfo.warn output
 address "address" bibinfo.check output
 format.date "year" output.check
 format.note output
 fin.entry
}

FUNCTION {misc}
{ output.bibitem
 format.authors output
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.title output
 howpublished "howpublished" bibinfo.check output
 format.date output
 new.block
 format.note output
 fin.entry
 empty.misc.check
}
FUNCTION {phdthesis}
{ output.bibitem
 format.authors "author" output.check
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.title
 "title" output.check
 bbl.phdthesis format.thesis.type output.nonnull
 school "school" bibinfo.warn output
 address "address" bibinfo.check output
 format.date "year" output.check
 format.note output
 fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
 editor empty$
   { organization "organization" bibinfo.check output
   }
   { format.editors output.nonnull }
 if$
   title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.btitle "title" output.check
 format.bvolume output
 format.number.series output
 editor empty$
   { publisher empty$
       'skip$
       {
         format.publisher.address output
       }
     if$
   }
   { publisher empty$
       {
         format.organization.address output }
       {
         organization "organization" bibinfo.check output
         format.publisher.address output
       }
     if$
    }
 if$
 format.note output
 fin.entry
}

FUNCTION {techreport}
{ output.bibitem
 format.authors "author" output.check
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.title
 "title" output.check
 format.tr.number output.nonnull
 institution "institution" bibinfo.warn output
 address "address" bibinfo.check output
 format.date "year" output.check
 format.note output
 fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
 format.authors "author" output.check
 title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
 format.title "title" output.check
 format.date output
 format.note "note" output.check
 fin.entry
}

FUNCTION {default.type} { misc }
READ
STRINGS { longest.label }
INTEGERS { number.label longest.label.width }
FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
 #1 'number.label :=
 #0 'longest.label.width :=
}
FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
 number.label #1 + 'number.label :=
 label width$ longest.label.width >
   { label 'longest.label :=
     label width$ 'longest.label.width :=
   }
   'skip$
 if$
}
EXECUTE {initialize.longest.label}
ITERATE {longest.label.pass}
FUNCTION {begin.bib}
{ preamble$ empty$
   'skip$
   { preamble$ write$ newline$ }
 if$
 "\begin{thebibliography}{"  longest.label  * "}" *
 write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.urlbst.variables} % urlbst
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
 "\end{thebibliography}" write$ newline$
}
EXECUTE {end.bib}
%% End of customized bst file
%%
%% End of file `cdaref.bst'.
