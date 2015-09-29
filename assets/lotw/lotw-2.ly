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
  title = "Four on Six (1:15-1:35)"
  composer = "Wes Montgomery"
}

% http://www.youtubeslow.com/watch?v=X8Ooy2mzrRk
the_lick = \relative c' {
 \key g \minor
 \time 4/4
 \numericTimeSignature
 \tempo "Med Up Swing" 4 = 200
 \partial 8 d8
 | g bes d f e4 c8 a
 | d,4 r8 g bes d-. r8 bes
 | c4 a8 f g4 e8 c 
 | e \glissando f d bes a g r8 ees
 \break
 \set TabStaff.minimumFret = #7
 | g bes a c ees f g4
 \set TabStaff.minimumFret = #5
 | g8 \glissando aes f des c bes f4
 \set TabStaff.minimumFret = #4
 | e8 fis g a b d r8 ges,8
 | bes\3 des c ees ges4 bes8 aes
 \set TabStaff.minimumFret = #3
 | a f d bes a f \clef bass d bes 
 | a f g a bes c d f
 | \clef treble e\4 g bes d f a g4 
 | e r8 des'4 c4 bes8 
 | g aes f ees d des r4
 | r4. g,8 c bes a4
 | g \tuplet 3/2 {g4 a4 a} d,4
 | r1
}

the_chords = \chordmode {
    \partial 8 g8:min7
    g1:min7 g1:min7 g1:min7 g1:min7
    c2:min7 f2:7 bes2:min7 ees2:7 a2:min7 d2:7 ees2:min7 aes2:7 
    g1:min7 g1:min7 g1:min7 c2:min7 f2:7
    bes1:maj7 a2:min7.5- d2:7 g1:min7 a2:min7.5- d2:7
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
        s1 \noBreak s1 \break
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