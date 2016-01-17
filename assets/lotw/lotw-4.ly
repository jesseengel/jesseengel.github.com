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
  title = "Pfrancing (0:58-1:20)"
  composer = "Wynton Kelly"
}

% http://www.youtubeslow.com/watch?v=X8Ooy2mzrRk
the_lick = \relative c'' {
 \key f \major
 \time 4/4
 \numericTimeSignature
 \tempo "Med Up Swing" 4 = 200
 \partial 2. \tuplet 3/2 {c8 d f} g4-^ aes8 a
 | f8 c a4 f r
 | r4 \tuplet 3/2 {r4 g'4 c8 d} c8 g
 | d8 c g4 d r
 | r4. g'8 c d ees d
 \break
 \set TabStaff.minimumFret = #7
 | a ees c4 g r
 | r8 c \tuplet 3/2 {ees c ees} e b gis4
 | d'8 f r d f, f r4
 | r4 f'8 d,4 f8 fis aes  
 \break
 | a8 c bes16 c bes a bes8 d16 bes g8 f
 | d8 bes a g c ees des16 ees des b
 | c8 f \tuplet 3/2 {aes8 a bes} a f c a 
 | bes8 c16 b a8 f \clef bass d c ees4
}

the_chords = \chordmode {
    \partial 2. c2.:7
    f1:7 bes1:7 f1:7 c2:min7 f2:7
    bes1:7 bes1:7 f1:7 a2:min7.5- d2:7 
    g1:min7 c1:7 f2:7 d2:7 g2:min7 c2:7
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
      % Add line breaks every 4 bars
      \repeat unfold 4 {
        s1 \noBreak s1 \noBreak
        s1 \noBreak
      }
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