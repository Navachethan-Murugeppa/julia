(define (prn x)
  (with-output-to *stderr*
		  (display x) (newline))
  x)

(define (lookup elt alst default)
  (let ((a (assq elt alst)))
    (if a (cdr a) default)))

(define (index-p pred lst start)
  (cond ((null? lst) #f)
	((pred (car lst)) start)
	(else (index-p pred (cdr lst) (+ start 1)))))

(define (diff s1 s2)
  (cond ((null? s1)         '())
	((memq (car s1) s2) (diff (cdr s1) s2))
	(else               (cons (car s1) (diff (cdr s1) s2)))))

(define (unique lst)
  (if (null? lst)
      '()
      (if (memq (car lst) (cdr lst))
	  (unique (cdr lst))
	  (cons (car lst) (unique (cdr lst))))))

(define (has-dups lst)
  (if (null? lst)
      #f
      (or (memq (car lst) (cdr lst))
	  (has-dups (cdr lst)))))

(define (contains p expr)
  (or (p expr)
      (and (pair? expr)
	   (any (lambda (x) (contains p x))
		expr))))

(define *gensyms* '())
(define *current-gensyms* '())
(define (gensy)
  (if (null? *current-gensyms*)
      (let ((g (gensym)))
	(set! *gensyms* (cons g *gensyms*))
	g)
      (begin0 (car *current-gensyms*)
	      (set! *current-gensyms* (cdr *current-gensyms*)))))
(define (reset-gensyms)
  (set! *current-gensyms* *gensyms*))
