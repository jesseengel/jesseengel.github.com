\version "2.18.2"

% Use LillyJazz Font
\paper {
  #(define fonts
    (set-global-fonts
      #:music "lilyjazz"
      #:brace "lilyjazz"
      #:roman "lilyjazz-text"
      #:sans "lilyjazz-chord"
      #:factor (/ staff-height pt 20)
  ))
}

% No initial indent 
% No string nums in staff
\layout {
  indent = #0
  \omit Voice.StringNumber
}

%% Hide fret number: useful to draw slide into/from a casual point of
%% the fretboard.
hideFretNumber = {
  \once \hide TabNoteHead
  \once \hide NoteHead
  \once \hide Stem
  \once \override NoteHead.no-ledgers = ##t
  \once \override Glissando.bound-details.left.padding = #0.3
}

%%% INSERT LICK HERE %%%

\header {
  title = "Four on Six"
  composer = "Wes Montgomery"
}

% http://www.youtubeslow.com/watch?v=X8Ooy2mzrRk
the_lick = \relative c'' {
 \key g \minor
 \time 4/4
 \numericTimeSignature
   c4 a8 f g4 e8 c 
 \break 
   c'4 a8 f g4 e8 c
 | d4 bes8 g a4 f8 d 
 | e1
 \break
  \set TabStaff.minimumFret = #5
   a'4 f8 d e4 c8 a
 | bes'4 g8 e f4 d8 bes
 | c'4 a8 f g4 e8 c
 \break
   c'4 a8 f g4 e8 c
 | des4 bes8 ges aes4 fis8 des 
 | e8 g bes d c2
 \break
   r4 c'4 a8 f g4 
 | e8 c r2.
 | r2. c'4 
 | a8 f g4 e8 c r4
 \break
   r8 c'4 a8 f g4 e8
 | c r8 r2.
 | r2. r8 c'8~
 | c8 a8 f g4 e8 c r8
 

 
}

the_chords = \chordmode {
  g1:min7 
  g1:min7 g1:min7 g1:min7
  g1:min7 g1:min7 g1:min7
  g1:min7 c1:7 f1:maj7
  g1:min7 g1:min7 g1:min7
  
  
}


%%% END OF LICK %%%

\score {
  <<
  % Only print chords when they change
  \new ChordNames {
    \set chordChanges = ##t
    \the_chords
    }
  \new StaffGroup 
    <<
      % Add the staff
      \context Staff {\the_lick}
      % Add the tab
      \context TabStaff {
        \clef moderntab
        \set TabStaff.minimumFret = #9
        \set TabStaff.restrainOpenStrings = ##t
        \the_lick
        }
    >>
  >>
}