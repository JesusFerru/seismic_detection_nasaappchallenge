% CdA DOCUMENT CLASS -- versão 1.1 para LaTeX2e
%
% "LaTeX document class" para o periódico Cadernos de Astronomia (www.periodicos.ufes.br/astronomia) 
%
%
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cda}[16/06/2020 v1.0 
LaTeX document class para os Cadernos de Astronomia (UFES-Brasil)]
%
\newif\if@editor
\@editorfalse
%
\newif\if@license
\@licensefalse
%
\newif\if@english
\@englishfalse
%
\DeclareOption{editor}{\@editortrue \@licensetrue}
\DeclareOption{english}{\@englishtrue}
%
\ProcessOptions
%
\LoadClass[a4paper,twocolumn,11pt]{article}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
%
\if@english
	\RequirePackage[english]{babel}
	\def\BIBand{and}
\else
	\RequirePackage[brazil]{babel}
	\def\BIBand{e}
\fi
%
\bibliographystyle{cdaref-2}
%
\RequirePackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage[fit]{truncate}
\RequirePackage{flushend}
\RequirePackage[blocks]{authblk}
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage[font=footnotesize,labelfont=bf]{caption}
\RequirePackage{cite}
\RequirePackage[vskip=.5em,rightmargin=0em]{quoting}
\RequirePackage{fancyhdr}
%
\setlength\columnsep{20pt}
\setlength{\hoffset}{-.54cm}
\setlength{\textwidth}{17cm}
\setlength{\voffset}{-1.04cm}
\setlength{\topmargin}{0cm}
\setlength{\headsep}{.5cm} 
\setlength{\headheight}{0.75cm}
\setlength{\textheight}{24.7cm} 
\setlength{\footskip}{1cm}
%
%
\newcommand*{\volume}[1]{\gdef\@volume{#1}}
\newcommand{\@volume}{...}
\newcommand*{\numero}[1]{\gdef\@numero{#1}}
\newcommand{\@numero}{...}
\newcommand*{\pagina}[1]{\gdef\@pagina{#1}}
\newcommand{\@pagina}{p000}
\newcommand*{\ano}[1]{\gdef\@ano{#1}}
\newcommand{\@ano}{XXXX}
\newcommand*{\oautor}[1]{\gdef\@oautor{#1}}
\newcommand{\@oautor}{}
\newcommand*{\doi}[1]{\gdef\@doi{#1}}
\newcommand*{\@doi}{nodoi}
%\newcommand*{\edtitulo}[1]{\gdef\@edtitulo{#1}}
%\newcommand*{\@edtitulo}{XX.XXXX/XXX}
\newcommand{\serie}[1]{%
	\gdef\@serie{#1}
}
\newcommand{\@serie}{}
%\newcommand*{\licenseon}{\gdef\@license{on}}
%\newcommand*{\@license}{}
%
%
\fancypagestyle{artigo}{%
\fancyfoot{}
\fancyhead{}
\fancyhead[L]{\footnotesize \truncate{0.55\headwidth}{\@title}}
\fancyhead[R]{\footnotesize \@oautor}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
\fancyfoot[R]{\thepage}
\if@editor
	\fancyfoot[L]{\footnotesize Cadernos de Astronomia, vol.\,\@volume, n$ ^\circ$\@numero, \@pagina\, (\@ano)}
\else
\fi
}
%
\fancypagestyle{capa}{%
	\fancyhead[]{}%
	\if@editor
		\fancyhead[C]{\footnotesize \fontfamily{lmr} \selectfont \uppercase{Cadernos de Astronomia} -- vol. \@volume, n$ ^\circ$\@numero\, (\@ano)\\[1ex] {\fontshape{it} \selectfont  \@serie}}
	\else\fi
	\renewcommand{\headrulewidth}{0pt}%
	\fancyfoot{}%
%	\ifthenelse{\equal{\@license}{on}}{%
	\if@license
		\fancyfoot[L]{\includegraphics[scale=0.01]{CC} \includegraphics[scale=0.01]{BY} \scriptsize Licença Creative Commons}%
%	}{}%
	\else\fi
	\fancyfoot[R]{\thepage}%
}
%
\fancypagestyle{editorial}{%
	\fancyfoot{}
	\fancyhead{}
	\fancyhead[L]{\fontfamily{lmr} \selectfont Editorial}
	\fancyfoot[R]{\thepage}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
	\fancyfoot[L]{\footnotesize Cadernos de Astronomia vol.\,\@volume, n$ ^\circ$\@numero\, (\@ano)}
}
%
\fancypagestyle{notas}{%
	\fancyfoot{}
	\fancyhead{}
	\fancyhead[L]{\fontfamily{lmr} \selectfont Notas}
	\fancyfoot[R]{\thepage}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
	\fancyfoot[L]{\footnotesize Cadernos de Astronomia vol.\,\@volume, n$ ^\circ$\@numero\, (\@ano)}
}
%
\fancypagestyle{intro}{%
	\fancyfoot{}
	\fancyhead{}
	\fancyhead[L]{\fontfamily{lmr} \selectfont \@serie~- Apresentação}
	\fancyfoot[R]{\thepage}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
	\fancyfoot[L]{\footnotesize Cadernos de Astronomia vol.\,\@volume, n$ ^\circ$\@numero, \@pagina\, (\@ano)}
}
%
\fancypagestyle{sumario}{%
	\fancyfoot{}
	\fancyhead{}
	\fancyhead[L]{\fontfamily{lmr} \selectfont Sumário}
	\fancyfoot[R]{\thepage}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
	\fancyfoot[L]{\footnotesize Cadernos de Astronomia vol.\,\@volume, n$ ^\circ$\@numero\, (\@ano)}
}
%
\setlength{\affilsep}{.5em}
\renewcommand{\Affilfont}{\large \fontfamily{lmr} \fontshape{sl} \selectfont}
\renewcommand{\Authfont}{\Large \fontfamily{lmr} \fontshape{n} \selectfont}
%
\newcommand{\autor}[2][]{\author[#1]{#2}}
\newcommand{\instituto}[2][]{%
	\ifthenelse{\equal{#1}{}}{%
		\affil{#2} \renewcommand{\Authsep}{, }
		\renewcommand{\Authand}{ e }
		\renewcommand{\Authands}{ e }}{%
		\affil[#1]{\hspace{-.45cm} #2}
	\renewcommand{\Authsep}{, \hspace{-.5cm} }
	\renewcommand{\Authand}{ e \hspace{-.35cm}}
	\renewcommand{\Authands}{ e \hspace{-.35cm}}}
}
%
\newcommand{\titulo}[1]{\title{#1}}
\newcommand*{\resumo}[1]{\gdef\@resumo{#1}}
\newcommand*{\@resumo}{Use \texttt{\string\resumo\{...\}} para escrever o resumo do artigo}
\renewcommand*{\abstract}[1]{\gdef\@abstract{#1}}
\newcommand{\@abstract}{Use \texttt{\string\abstract\{...\} para escrever um resumo em inglês}}
\newcommand*{\pchave}[1]{\gdef\@pchave{#1}}
\newcommand*{\@pchave}{Use \texttt{\string\pchave\{...\}} para adicionar as palavras-chave do artigo}
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand*{\@keywords}{Use \texttt{\string\keywords\{...\}} para adicionar as palavras-chave do artigo}
%
%
%
%
\renewcommand*{\maketitle}{%
	\twocolumn[%
	\vspace{.3cm}%
	\begin{flushleft}%
		{\LARGE \fontfamily{bch} \fontshape{sl} \selectfont \@title \par }%
		\vskip 1.0em%
		 \@author %
	\end{flushleft}%
	\hrulefill \par
	{\normalsize \bfseries Resumo \par}%
	{\small \selectfont \@resumo \par  }%
	\vskip .5em%
	{\normalsize \bfseries Abstract \par}%
	{\small \selectfont \@abstract \par  }%
	\vskip .5em%
	\hrule 
	\par
	\vskip 1em%
	{\small {\bfseries Palavras-chave:} \@pchave \par}%
	{\small {\bfseries Keywords:} \@keywords \par}%
	\ifthenelse{\equal{\@doi}{nodoi}}{}{%
	\vskip 1em%
	{\small DOI: \href{http://doi.org/10.47456/Cad.Astro.v\@volume n\@numero.\@doi}{10.47456/Cad.Astro.v\@volume n\@numero.\@doi}}%
	}
	\vskip 2.5em]%
	\thispagestyle{capa}%
}
%\doi{10.47083/Cad.Astro.v1n1.31678}
%Antigo prefixo DOI: 10.47083
%
\RequirePackage{titlesec}
\titleformat{\section}[hang]{\bfseries \normalsize \fontshape{sl} \selectfont \raggedright }{\thesection}{0.2cm}{}
\titlespacing{\section}{0pt}{*6}{*1.5}
%
\titleformat{\subsection}[hang]{\bfseries \normalsize \fontshape{sl} \selectfont \raggedright }{\thesubsection}{0.2cm}{}
\titlespacing{\subsection}{0pt}{*3}{*1.5}
%
\titleformat{\subsubsection}[hang]{\bfseries \normalsize \fontshape{sl} \selectfont \raggedright }{\thesubsubsection}{0.2cm}{}
\titlespacing{\subsubsection}{0pt}{*2}{*1.5}
%
\renewcommand{\appendix}{%
	\setcounter{section}{0}
	\renewcommand{\thesection}{\Alph{section}}
	\titleformat{\section}[block]{\bfseries \normalsize \fontshape{sl} \selectfont \raggedright }{Apêndice~\thesection:}{0.2cm}{}
	\titlespacing{\section}{0pt}{*6}{*1.5}	
}
%
%\titleclass{\apendice}{straight}[\subsection]
%\newcounter{apendice}
%\renewcommand{\theapendice}{\Alph{apendice}}
%\titleformat{\apendice}[block]{\bfseries \normalsize \fontshape{sl} \selectfont \raggedright }{Apêndice\,\theapendice}{0cm}{:~}
%\titlespacing{\apendice}{0pt}{*6}{*1.5}
%
%
\newcommand*{\cond}[1]{\gdef\@cond{#1}}
\newenvironment{sobreautor}[1][m]{%
	\ifthenelse{\equal{#1}{m}}{\cond{o autor}}{}
	\ifthenelse{\equal{#1}{mp}}{\cond{os autores}}{}
	\ifthenelse{\equal{#1}{f}}{\cond{a autora}}{}
	\ifthenelse{\equal{#1}{fp}}{\cond{as autoras}}{}
	\ifthenelse{\equal{#1}{t}}{\cond{o tradutor}}{}
	\ifthenelse{\equal{#1}{tp}}{\cond{os tradutores}}{}
	\vskip 2em%
	\hrule
	\vspace{-2em}%
	\section*{Sobre \@cond}}{}
%
%
%
\newenvironment{agradecimentos}{\section*{Agradecimentos}}{\par}
\newcommand{\agrad}{\section*{Agradecimentos}}
%
%
\RequirePackage{setspace}
\newenvironment{editorial}[1][Inserir título usando {\string\begin\{editorial\}[Título]}]{%
	\pagestyle{editorial}%
	\onecolumn%
	\vspace*{.5cm}%
	\begin{center}%
		{\huge \fontfamily{bch} \fontshape{sl} \selectfont #1 \par }%
		\vskip 2.5em%
	\end{center}%
\spacing{1.2}
\large
}{\endspacing \par \clearpage}
%
\newenvironment{notas}[1][Inserir título usando {\string\begin\{editorial\}[Título]}]{%
	\thispagestyle{capa}%
	\titulo{#1}
	\serie{Notas}
	\oautor{Notas}
	\onecolumn%
	\vspace*{.5cm}%
	\begin{center}%
		{\huge \fontfamily{bch} \fontshape{sl} \selectfont #1 \par }%
		\vskip 2.5em%
	\end{center}%
	\spacing{1.2}
	\large
}{\endspacing \par \clearpage}
%
\newenvironment{intro}[1][Inserir título usando {\string\begin\{editorial\}[Título]}]{%
	\pagestyle{intro}%
	\onecolumn%
	\vspace*{.5cm}%
	\begin{center}%
		{\huge \fontfamily{bch} \fontshape{sl} \selectfont #1 \par }%
		\vskip 2.5em%
	\end{center}%
	\spacing{1.2}
	\large
}{\endspacing \par \clearpage}
%
\newcommand{\as}[1]{%
	\vspace{.5cm}
	\raggedleft \textit{#1}
}
%
\newcommand{\figref}[1]{Figura \ref{#1}}
\newcommand{\tabref}[1]{Tabela \ref{#1}}
%
%%% Corrigindo os comandos seno e tangente

\providecommand{\sin}{} \renewcommand{\sin}{\hspace{2pt}\mathrm{sen}}
\providecommand{\tan}{} \renewcommand{\tan}{\hspace{2pt}\mathrm{tg}}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\RequirePackage[hyperindex,colorlinks,linkcolor=blue,citecolor=cyan,urlcolor=blue,linktocpage,breaklinks=true]{hyperref}
%
\pagestyle{artigo}
%
%Final do arquivo 'cda.cls'