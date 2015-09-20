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

\header {
  title = "Pent-Up House (0:40-0:50)"
  composer = "Clifford Brown"
}

the_lick = \relative c'' {
 \key g \major
 \time 4/4
 \numericTimeSignature
 \tempo "Med Up Swing" 4 = 200
 | r4 d2.
 | r8  b-. r \appoggiatura cis d bes4 r8 \appoggiatura cis d
 | a1\2
 | r4 r8 \< a\2 b\2 c\2 d e \!
 | g e c\2 a\3 e4-.\4 g8\3 e\4 
 | fis a c d  f c cis e
 | d-! bes r b d fis, r a
 | g d2
}

the_chords = \chordmode {
    a1:min7 d:7 g:maj7 g:maj7
    a1:min7 d:7 g:maj7 g:maj7
}

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
      \repeat unfold 2 {
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