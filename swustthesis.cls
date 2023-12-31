\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{swustthesis}[2016/06/11 v0.0.1 SWUST thesis template]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=swust@opt,prefix=swust@opt@,setkeys=\kvsetkeys}
\DeclareBoolOption[false]{doctor}
\DeclareBoolOption[false]{master}
\DeclareBoolOption[false]{bachelor}

\SetupKeyvalOptions{family=swust@page,prefix=swust@page@,setkeys=\kvsetkeys}
\DeclareBoolOption[false]{oneside}
\DeclareBoolOption[false]{openany}
\DeclareComplementaryOption{twoside}{oneside}
\DeclareComplementaryOption{openright}{openany}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}

\ProcessKeyvalOptions{swust@opt}

% TODO: Add English thesis name.
\ifswust@opt@bachelor
	\newcommand{\swust@thesis@name}{西南科技大学博士论文}
        \swust@opt@bachelortrue
\else
	\ifswust@opt@master
		\newcommand{\swust@thesis@name}{西南科技大学硕士论文}
                \swust@opt@mastertrue
        \else
        	\newcommand{\swust@thesis@name}{西南科技大学本科生毕业论文}
                \swust@opt@doctortrue
                \swust@page@onesidetrue
        \fi
\fi

\ifswust@page@openany
	\PassOptionsToClass{openany}{ctexbook}
\fi

\ifswust@page@oneside
	\PassOptionsToClass{oneside}{ctexbook}
\fi

\LoadClass[a4paper, UTF8, zihao=-4]{ctexbook}

\def\swust@define@term#1{
  \expandafter\gdef\csname #1\endcsname##1{
    \expandafter\gdef\csname swust@#1\endcsname{##1}
  }
  \csname #1\endcsname{}
}

\swust@define@term{title}
\swust@define@term{author}
\swust@define@term{date}
\swust@define@term{studentid}
\swust@define@term{department}
\swust@define@term{major}
\swust@define@term{advisor}
\swust@define@term{englishtitle}

\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}

\newCJKfontfamily{\hwxk}{STXingkai}

\RequirePackage{hyperref}
\hypersetup{
  CJKbookmarks=true,
  bookmarksopen=true,
  bookmarksnumbered=true,
  bookmarksopenlevel=1,
  pdfborder=0 0 0,
  unicode=true,
  linktoc=all,
  allcolors=black,
  colorlinks=true,
}

\RequirePackage{geometry}
\ifswust@opt@doctor
	\geometry{
	  paper=a4paper,
          top=3.0cm,bottom=3.0cm,
          left=3.0cm,right=2.5cm,
          headheight=2.0cm,footskip=1.0cm,
	}
\else
	\geometry{
	  paper=a4paper,
          paperwidth=21.0cm,paperheight=29.7cm,
          top=3.0cm,bottom=2.5cm,
          left=2.6cm,right=2.6cm,
          bindingoffset=0.0cm,
          headheight=2.0cm,footskip=0.75cm,
        }
\fi


\RequirePackage[pagestyles]{titlesec}

\newcommand{\swust@header}{\swust@thesis@name}
\newcommand{\swust@header@size}{\zihao{5}}
\ifswust@opt@doctor
	\newcommand{\swust@header@font}{\hwxk}
\else
        \newcommand{\swust@header@font}{\songti}
\fi

\newpagestyle{front}[\swust@header@size\swust@header@font]{
  \ifswust@opt@doctor
  	\sethead{}{\swust@header}{\thepage}
  	\renewcommand{\makeheadrule}{
  	  \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
  	  \rule[-.5\baselineskip]{\linewidth}{2pt}
  	}
  \else
        \sethead[][\swust@header][]{}{\chaptertitle}{}
        \setfoot[\thepage][][]{}{}{\thepage}
  	\renewcommand{\makeheadrule}{
  	  \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
  	  \rule[-.4\baselineskip]{\linewidth}{.5pt}
  	}        
        \setfootrule{.5pt}
  \fi
}

\newpagestyle{main}[\swust@header@size\swust@header@font]{
  \ifswust@opt@doctor  	
  	\sethead{}{\swust@header}{}
  	\setfoot{}{\thepage}{}
  	\renewcommand{\makeheadrule}{
  	  \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
  	  \rule[-.5\baselineskip]{\linewidth}{2pt}
  	}
  \else  	
        \sethead[][\swust@header][]{}{\chaptertitle}{}
        \setfoot[\thepage][][]{}{}{\thepage}
        \renewcommand{\makeheadrule}{
  	  \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
  	  \rule[-.4\baselineskip]{\linewidth}{.5pt}
  	}
        \setfootrule{.5pt}
  \fi
}

\renewcommand{\frontmatter}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{front}
}

\renewcommand{\mainmatter}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{main}
}

\renewcommand{\chapter}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \global\@topnum\z@
  \@afterindenttrue
  \secdef\@chapter\@schapter
}
\ifswust@opt@doctor
\ctexset{
  chapter       = {
    name        = {第,章},
    number      = \thechapter,
    format      = \centering\zihao{-2}\heiti,
    beforeskip  = 2ex,
    afterskip   = 1ex,
  },
  section       = {
    format      = \raggedright\zihao{4}\heiti,
    beforeskip  = 1ex,
    afterskip   = .5ex,
  },
  subsection    = {
    format      = \raggedright\zihao{-4}\songti,
    beforeskip  = .5ex,
    afterskip   = 0ex,
  },
  subsubsection = {
    format      = \raggedright\zihao{-4}\songti,
    beforeskip  = 0ex,
    afterskip   = 0ex,
  },
}
\else

\ctexset{
  chapter       = {
    name        = {},
    number      = \thechapter,
    format      = \centering\zihao{3},
    beforeskip  = 2ex,
    afterskip   = 1ex,
  },
  section       = {
    format      = \raggedright\zihao{-3},
    beforeskip  = 1ex,
    afterskip   = .5ex,
  },
  subsection    = {
    format      = \raggedright\zihao{4},
    beforeskip  = .5ex,
    afterskip   = 0ex,
  },
  subsubsection = {
    format      = \raggedright\zihao{-4},
    beforeskip  = 0ex,
    afterskip   = 0ex,
  },
}
\fi

\newcommand{\swust@pdf@contentsname}{目录}
\let\swust@save@tableofcontents=\tableofcontents
\renewcommand{\tableofcontents}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \pdfbookmark[0]{\swust@pdf@contentsname}{swusttoc}
  \swust@save@tableofcontents
}

\RequirePackage{titletoc}
\newcommand{\swust@toc@leaders}{\titlerule*[.5pc]{$\cdot$}}
% The format of TOC will be different between doctor and master/bachelor.
% So we can modify the format at here.
\ifswust@opt@doctor
	\newcommand{\swust@chap@font}{\heiti}
	\newcommand{\swust@chap@size}{\zihao{-4}}
	\newcommand{\swust@sect@font}{\songti}
	\newcommand{\swust@sect@size}{\zihao{-4}}
	\newcommand{\swust@subs@font}{\songti}
	\newcommand{\swust@subs@size}{\zihao{-4}}
        \newcommand{\swust@chap@toc@indent}{0bp}
        \newcommand{\swust@sect@toc@indent}{2\ccwd}
        \newcommand{\swust@subs@toc@indent}{4\ccwd}
\else
	\newcommand{\swust@chap@font}{\heiti}
	\newcommand{\swust@chap@size}{\zihao{-4}}
	\newcommand{\swust@sect@font}{\songti}
	\newcommand{\swust@sect@size}{\zihao{-4}}
	\newcommand{\swust@subs@font}{\songti}
	\newcommand{\swust@subs@size}{\zihao{-4}}
        \newcommand{\swust@chap@toc@indent}{0bp}
        \newcommand{\swust@sect@toc@indent}{2\ccwd}
        \newcommand{\swust@subs@toc@indent}{4\ccwd}
\fi
        
\titlecontents{chapter}
              [\swust@chap@toc@indent]
              {\swust@chap@size\swust@chap@font}
              {\thecontentslabel\hspace*{.5em}}
              {}{\swust@toc@leaders\contentspage}
\titlecontents{section}
              [\swust@sect@toc@indent]
              {\swust@sect@size\swust@sect@font}
              {\thecontentslabel\hspace*{.5em}}
              {}{\swust@toc@leaders\contentspage}
\titlecontents{subsection}
              [\swust@subs@toc@indent]
              {\swust@subs@size\swust@subs@font}
              {\thecontentslabel\hspace*{.5em}}
              {}{\swust@toc@leaders\contentspage}
        

\renewcommand{\maketitle}{
  \newgeometry{
    top=3cm,bottom=3cm,
    left=3cm,right=2.5cm,
    headheight=2cm, footskip=.5cm,
  }
  \pagestyle{empty}
  \pdfbookmark[0]{封面}{titlepage}
  \swust@maketitle
  \restoregeometry
}

\ifswust@opt@doctor
	\newcommand{\swust@maketitle}{
	  
          \begin{titlepage}
            \vspace*{1cm}
            \begin{minipage}{3cm}
                \includegraphics[width=3cm]{figures/swust_logo_fig}
            \end{minipage}
            \begin{minipage}{4cm}
              \begin{tabular}{c}
                \includegraphics[width=9cm]{figures/swust_logo_text}\\
                \zihao{3}Southwest university of science and technology\\
              \end{tabular}
            \end{minipage}
            
            \centering
            \vspace{2cm}
	    \heiti\zihao{-0}本科毕业设计（论文）\\
	    \vspace{3cm}
	    \zihao{2}\swust@title\\
            \vspace{3cm}
	    \zihao{-3}
	    \begin{tabular}{cc}
	      \makebox[4em][s]{学院名称} & \underline{\makebox[16em]{\swust@department}} \\
	      \makebox[4em][s]{专业名称} & \underline{\makebox[16em]{\swust@major}} \\
	      \makebox[4em][s]{学生姓名} & \underline{\makebox[16em]{\swust@author}} \\
	      \makebox[4em][s]{学号}     & \underline{\makebox[16em]{\swust@studentid}} \\
	      \makebox[4em][s]{指导教师} & \underline{\makebox[16em]{\swust@advisor}} \\
	    \end{tabular}\\            
	    \vspace{3cm}
            \swust@date
	  \end{titlepage}
	}
\else
	\newcommand{\swust@maketitle}{
	  \begin{titlepage}
            \vspace*{3cm}
	    \centering
	    \zihao{-2}\textbf{\swust@thesis@name}
	    \vskip 3cm
	    \heiti\zihao{2}\swust@title
	    \vskip 4cm
	    \songti\zihao{3}\swust@author
	    \vskip 0cm
	    \swust@studentid
	    \vskip 7cm
	    \zihao{-4}\swust@date
	  \end{titlepage}
	}
\fi

\ifswust@opt@doctor
	\newenvironment{abstract}{
	  \begin{center}
	    \vspace*{2ex}
            \pdfbookmark[0]{摘要}{abstract}
	    \zihao{-1}\heiti\swust@title
	    \vspace{1ex}
	  \end{center}

          {
	    \noindent\zihao{-4}\heiti 摘要:
          }
	}
	
	\newcommand{\keywords}[2][\zihao{-4}]{
	  \par\phantom{关键词}\par\noindent
          {
	    #1{\heiti 关键词: }#2
          }
	}
	
	\newenvironment{englishabstract}{
	  \newpage
	  \begin{center}
	    \vspace*{2ex}
            \pdfbookmark[0]{Abstract}{englishabstract}
	    \zihao{-2}\textbf{\swust@englishtitle}
	    \vspace{1ex}
	  \end{center}
	
	  \noindent\zihao{-4}\textbf{Abstract :}
	}
	
	\newcommand{\englishkeywords}[2][\zihao{-4}]{
	  \par\phantom{keywords}\par\noindent
          {
	    #1\textbf{Key words: }#2
          }
	}
\else
	\newenvironment{abstract}{
	  \chapter[摘要]{摘\quad 要}
	}
	
	\newcommand{\keywords}[2][\zihao{5}]{
	  \par\phantom{关键词}\par\noindent
	  {
	    #1\textbf{关键词：}#2
	  }
	}
	
	\newenvironment{englishabstract}{
	  \chapter[Abstract]{ABSTRACT}
	  \setlength{\parskip}{2ex}
	  \setlength{\parindent}{0pt}
	}
	
	\newcommand{\englishkeywords}[2][\zihao{5}]{
	  \par\phantom{keywords}\par\noindent
	  {
	    #1\textbf{KEY WORDS: }#2
	  }
	}
\fi

\renewcommand{\contentsname}{目\qquad 录}

\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{caption}
\RequirePackage{longtable}
\numberwithin{table}{chapter}
\renewcommand{\thetable}{\thechapter-\arabic{table}}

\DeclareCaptionLabelSeparator{zhspace}{\hspace{\ccwd}}
\DeclareCaptionFont{capfont}{\zihao{5}}
\newcommand{\contableformat}{\zihao{5}}
\captionsetup{
  font = {capfont,bf},
  labelsep = quad,
}

\captionsetup[table]{
  position = top,
  aboveskip = 6bp,
  belowskip = 6bp,
}

\graphicspath{{figures/}{./}}
\numberwithin{figure}{chapter}
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
