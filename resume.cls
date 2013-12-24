\ProvidesClass{resume}[2013/12/24 v1.0 Resume class]

\LoadClass[11pt,letterpaper]{article} % Font size and paper type

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements

\pagestyle{empty} % Suppress page numbers


%----------------------------------------------------------------------------------------
%	HEADINGS COMMANDS: Commands for printing name and address
%----------------------------------------------------------------------------------------

\def\namesize{\huge} % Size of the name at the top of the document
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section 
\def\nameskip{\bigskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default
\def \addressSep {$|$} % Set default address separator to a diamond

\def\StrReplace#1#2#3{
  \IfSubStr{#3}{#1}{
    \StrSubstitute{#3}{#1}{#2}}{#3}}

% One, two or three address lines can be specified 
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

% \address command can be used to set the first, second, and third address (last 2 optional)
\def \address #1{
  \@ifundefined{@addresstwo}{
    \def \@addresstwo {#1}
  }{
  \@ifundefined{@addressthree}{
  \def \@addressthree {#1}
  }{
    \def \@addressone {#1}
  }}
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \hfil{\MakeUppercase{\namesize\bf \@name}}\hfil
  \vspace{0.35 em}
  \endgroup
}


%----------------------------------------------------------------------------------------
%	PRINT THE HEADING LINES
%----------------------------------------------------------------------------------------

\let\ori@document=\document

\renewcommand{\document}{
  \ori@document  % Begin document
  \printname % Print the name specified with \name
  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \printaddress{\@addresstwo}}
     \@ifundefined{@addressthree}{}{ % Print the third address if specified
    \printaddress{\@addressthree}}
    \vspace{-0.2 em}
}


%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  \sectionskip
  \MakeUppercase{\bf #1} % Section title
  \sectionlineskip
  \hrule % Horizontal line
  \begin{list}{}{ % List for each individual item in the section
    \setlength{\leftmargin}{1.5em} % Margin within the section
  }
  \item[]
}{
  \end{list}
}


%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

% 4 input arguments - title, company, location and year(s) employed
\newenvironment{rSubsection}[4]{
  \ifthenelse{\equal{#3}{}} {
    {\bfseries{#1}}, #2 \hfill {\StrReplace{ }{}{#4}} % Print this if location is not specified
  } {
    {\bfseries{#1}}, #2, {\em #3} \hfill {\StrReplace{ }{}{#4}} % Print italicized location if specified
  }
  \smallskip
  \begin{list}{$\bullet$} {\leftmargin=2em\rightmargin=\dimexpr\linewidth-14cm-\leftmargin\relax}
  \itemsep -0.5 em
  \vspace{-0.7 em}
  }{
  \end{list}
  \vspace{-0.2 em}
}


%----------------------------------------------------------------------------------------
% WORK LISTING FORMATTING
%----------------------------------------------------------------------------------------

% Regular list with no indentation
\newenvironment{rSubListing}{
  \begin{list}{$\bullet$}{\leftmargin=1em\rightmargin=0.75em}
    \itemsep -0.5 em \vspace{-0.0 em}
  }{
  \end{list}
  \vspace{-0.2 em}
}


%----------------------------------------------------------------------------------------
% EDUCATION FORMATTING
%----------------------------------------------------------------------------------------

% 4 input arguments - school, degree, major and year
\newenvironment{rEducation}[4]{
  \ifthenelse{\equal{#3}{}} {
    {\bfseries{#1}}, #2 \hfill {\StrReplace{ }{}{#4}} % Print this if location is not specified
  } {
    {\bfseries{#1}}, #2, {\em #3} \hfill {\StrReplace{ }{}{#4}} % Print italicized location if specified
  }
  \smallskip
  \em\begin{list}{\bfseries{Relevant Courses:}}{\leftmargin=3.5em\rightmargin=\dimexpr\linewidth-14cm-\leftmargin\relax} % prefix li with 'Relevant Courses:'
  \itemsep -0.5 em \vspace{-0.7 em}
  }{
  \end{list}
  \vspace{-0.2 em}
}
