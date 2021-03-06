#lang racket

(require "board-object.rkt")
(require "othello-ui.rkt")
(provide (all-defined-out))

;En fil där vi skapar våra två olika board, det vanliga som är det som kommer att synas när vi spelar
;och ett AI-board som vi kommer att använda då vi spelar mot en AI.
;Mirjam Mattsson, Mathias Svanberg
;senast uppdaterad 24/5-2016

;definirerar de olika boardsen
(define *board*
  (new boards%))

(define *AI-board*
  (new boards%))


(define (start-board x y)
  (cond ((and (= x 7) (= y 7)) (begin (send *board* add-to-board (cons x y)) '()))
        ((= x 7) (begin (send *board* add-to-board (cons x y)) (start-board 0 (+ y 1))))
        (else (begin (send *board* add-to-board (cons x y)) (start-board (+ x 1) y)))))

;lägger till alla moves i board-listan
(start-board 0 0)


;Startbrädet
;hjälpfunktion
(define (start-board-help move color)
  (set-piece-at! (car move) (cdr move) color)
  (send *board* board-to-move move)
  (if (equal? color 'WHITE)
      (send *board* add-white-list! move)
      (send *board* add-black-list! move)))

(define (start-pieces)
  (start-board-help (cons 3 3) 'BLACK)
  (start-board-help (cons 4 4) 'BLACK)
  (start-board-help (cons 3 4) 'WHITE)
  (start-board-help (cons 4 3) 'WHITE))
