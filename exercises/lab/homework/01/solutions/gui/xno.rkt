#lang racket/gui

;;; Abandon all hope, ye who enter here

(provide main)

(require "utils.rkt")
(require "../xno.rkt")

; Top level frame to contain everything else.
(define frame (new frame%
                   (label "Noughts and crosses")
                   (stretchable-height #t)
                   (stretchable-width #t)))

; Winner message.
(define winner-msg
  (new message%
       (parent frame)
       (label "")))

; Map from "players" to their symbols.
; #t is the X player and #f is the O player.
(define (symbol x)
  (if x "X" "O"))

; #t for human #f for ai
(define curr-x-player #t)

(define game-ended #f)

; Global var to keep current player state.
; #t is for X, #f is for O
(define curr-player #t)

(define (winrar x)
  (string-append "A winrar is " x "!"))

; If x is not #f then we update the winner label with whatever x is.
(define (update-winrar x)
  (when x
    (begin
      (if (equal? x "D")
        (send winner-msg set-label "Game is a draw.")
        (send winner-msg set-label (winrar x)))
      (set! game-ended #t))))

(define (disable x)
  (send x enable #f))

(define (ai-move)
  (if game-ended
      (begin
        (sleep 2)
        (new-game)
        (unless curr-x-player
          (ai-move)))

      (let* ((aimove (play (board->list board-state) curr-player))
             (aix (car aimove))
             (aiy (cdr aimove)))
        (press-ai aix aiy))))

; Make a button that contains X's and O's.
(define (but par x y)
  (new button% (parent par)
       (label " ")
       (callback (lambda (button event)
                   (press button x y)))
       (stretchable-height #t)
       (stretchable-width #t)))

; Callback procedure for a button click:
; If the game has ended then we need to reset it
; and maybe make an AI move.
; We set the label to either a X or an O
; then we disable the button so we can't spam it.
; We then update the winner, depending if there is one at all.
; And afterwards we update the current player to the next one.

; We follow the convetion that after every button press
; we need to check whether we need to start a new game.
; In our "human press" we do this through the (ai-move) function.
; In our "ai press" we just do it at the end of the press.
(define (press button x y)
  (begin
    (send button set-label (symbol curr-player))
    (set-board! x y (symbol curr-player))
    (disable button)
    (update-winrar (winner (board->list board-state)))
    (set! curr-player (not curr-player))
    (ai-move)))

(define (press-ai x y)
  ; should have a function for this
  (define button (list-ref (list-ref board-gui x) y))

  ; copy pasted, should get extracted
  (send button set-label (symbol curr-player))
  (set-board! x y (symbol curr-player))
  (disable button)
  (update-winrar (winner (board->list board-state)))
  (set! curr-player (not curr-player))
  (when game-ended
      (begin
        (sleep 2)
        (new-game)
        (unless curr-x-player
          (ai-move)))))

; A row of buttons.
(define (row n x)
  (define newrow (new horizontal-panel% (parent frame)))

  (map (lambda (y) (but newrow x y)) (from-to 0 (- n 1))))

; The entire board.
(define (board n m)
  (map (lambda (x) (row m x)) (from-to 0 (- n 1))))

; so we can pass it to our implementers
(define (board->list board)
  (vector->list (vector-map vector->list board-state)))

(define (set-board! x y p)
  (vector-set! (vector-ref board-state x) y p))

(define (set-label! x y l)
  (send (list-ref (list-ref board-gui x) y) set-label l))

; not a hack ;)))))))))))
; yay for impurity
; kill me
(define board-gui void)
(define board-state
  (vector (vector #f #f #f)
          (vector #f #f #f)
          (vector #f #f #f)))

; resetting stuff

(define (reset-board-state)
  (begin
    (v-fmap! (const #f) board-state)
    void))

(define (reset-board-gui)
  (fmap reset-button board-gui))

(define (reset-button but)
  (begin
    (send but set-label "")
    (send but enable #t)))

; global.. yay.
(define (new-game)
  (set! curr-player #t)
  (set! curr-x-player (not curr-x-player))
  (set! game-ended #f)
  (reset-board-state)
  (send winner-msg set-label "")
  (reset-board-gui))

(define (main)
  (begin
    (set! board-gui (board 3 3))
    (send frame show #t)))
