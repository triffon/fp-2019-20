## 0. (2т.) k-ична бройна система

Да се имплементират две функции:
```scheme
(from-k-ary n k)
(to-k-ary n k)
```
За `k`, `0 < k < 10` и `n` - естествено:

`from-k-ary n k` трябва да обръща числото `n` в десетична бройна система от `k`-ична.

`to-k-ary n k` трябва да обръща числото `n` от десетична бройна система в `k`-ична.

Примери:
```scheme
(to-k-ary 215325215 7) ; се оценява до 5223143210

(from-k-ary 211231562734 8) ; се оценява до 18428126684

(from-k-ary (to-k-ary 123456780 9) 9) ; се оценява до 123456780
```

## 1. (2т.) Корен квадратен

Да се напише функция:
```scheme
(my-sqrt x)
```
която да апроксимира корен квадратен от `x`, за `x` положително.

Апроксимацията ви трябва да е полезна, тоест да съвпада до някаква
точност с истинския корен на `x` (например поне 4 знака след запетаята).

Най-добре е (но е незадължително) да може да се специфицира по лесен начин с каква точност ще се апроксимира.

За целта най-вероятно ще искате да ползвате [метода на Нютон за апроксимация на корени]
([секцията с примерите е полезна], има и информация другаде из нета).

## 2. "n-кратно прилагане на функция към стойност" - нумерали

**По-надолу всичките числа се приемат за естествени числа (>=0).**

Нека си мислим за "n-кратно прилагане на функция `f` към стойност `v`" като някаква абстракция.
Това представлява функция, която взима аргументи `f` и `v` и прилага `n` пъти `f` над `v`.

За краткота по-надолу "n-кратно прилагане на функция към стойност" ще наричаме "нумерала `n`".

Да видим как изглеждат нумералите 0, 1 и 2.
```scheme
(define zero (lambda (f v) v))

```
Да приложим 0 пъти `f` към `v` е същото като просто да имаме `v`.
```scheme
(define one (lambda (f v) (f v)))
(define two (lambda (f v) (f (f v))))
```
И съответно можем да използваме нумералите, подавайки им функция която ще извикваме и стойност над която да се прилага.
```scheme
(define (1+ n) (+ 1 n))
(two 1+ 3) ; се оценява до 5
```

Иска ни се ако имаме нумерала `n` да можем а направим нумерала `n + 1`.
С други думи, ако можем да приложим `n` пъти функция, да има начин да я приложим `n + 1` пъти.
```scheme
(define (succ n)  ; взимаме нумерала ни n
  (lambda (f v)   ; ще конструираме нов нумерал
    (f (n f v)))) ; за да построим n + 1-кратно прилагане, просто прилагаме n пъти f към v,
                  ; след което добавяме още едно прилагане

((succ (succ two)) 1+ 10) ; се оценява до 14
```

Вашите задачи са следните:

0. (1т.) Имплементирайте функцията `(from-numeral n)`, която по даден нумерал `n` връща числото `n`
    (т.е. колко пъти се прилага функцията).
1. (1т.) Имплементирайте функцията `(to-numeral n)`, която по дадено число `n` връща нумерала `n`.

    **За тези две функции трябва да са верни свойствата:**
    * За всяко естествено число `n` `(from-numeral (to-numeral n))` трябва да е равно на `n`.
    * За всеки нумерал `n` `(to-numeral (from-numeral n))` трябва да е същото като оригиналния нумерал `n`.

    Това че можем да конвертираме от и към числа, без да губим информация (това казват свойствата),
    ни навежда към мисълта че това да имаме числа в езика ни е излишно, стига да имаме нумерали.

    А нумералите реално са само ламбда функции, т.е. ламбда функциите могат да заменят числата в езика ни.

    **Примери**:
    ```scheme
    (from-numeral zero) ; се оценява до 0
    (from-numeral (succ (succ (succ (succ zero))))) ; се оценява до 4
    ((to-numeral 10) (lambda (x) (* x 2)) 1) ; се оценява до 1024
    (to-numeral (+ (from-numeral 20) (from-numeral 49))) ; се оценява до нумерала 69
    ```

2. (2т.) Използвайки само ламбда функции, `zero` и `succ`, имплементирайте функцията `(plus n m)`,
    която по дадени нумерали `n` и `m` връща нумерала `n + m`.

    **Примери**:
    ```scheme
    (from-numeral (plus zero (succ (succ zero)))) ; се оценява до 2
    (plus (to-numeral 7) (to-numeral 3)) ; се оценява до нумерала 10
    (from-numeral (plus (to-numeral 7) (to-numeral 3))) ; се оценява до 10
    ((plus (to-numeral 3) (to-numeral 5)) 1+ 10) ; се оценява до 18
    ```

    **Hint**:
    Функцията може да бъде реализирана или "директно" или "недиректно".

    Под "директно" имам предвид, че както при `succ` сглобяваме направо нов нумерал, така и тук
    можем "ръчно" да си сглобим нов нумерал.

    "Недиректният" подход е този при който се възполваме от факта че реално нумералите ни са
    `n` пъти прилагане на функция над стойност. Този подход много прилича на използването на `iterate`
    за имплементация на събиране.

3. (2т.) Използвайки само ламбда функции, `zero`, `succ` и `plus`, имплементирайте функцията `(mult n m)`,
    която по дадени нумерали `n` и `m` връща нумерала `n * m`.

    **Примери**:
    ```scheme
    (from-numeral (mult zero (succ (succ zero)))) ; се оценява до 0
    (mult (to-numeral 7) (to-numeral 3)) ; се оценява до нумерала 21
    ((mult (to-numeral 3) (to-numeral 5)) 1+ 10) ; се оценява до 25
    ```

    **Hint**-ът от по-горе важи и тук, като недиректният подход е може би доста по-лесен.
    (но е интересно да се пробва и другото)

    Не забравяйте че нумералите очакват **функция на един аргумент!**

4. (4т.) (труден) Бонус - Използвайки само ламбда функции (и по-горните дефиниции), имплементирайте `(pred n)`,
    която по даден нумерал `n` връща нумерала 0 ако `n` е нумерала 0, или нумерала `n - 1` в противен случай.

    **Hint**:
    Пробвайте да имплементирате функцията, както бихте на `scheme` използвайки каквито ресурси искате,
    и после изразете нещата които сте използвали чрез ламбда функции.


[метода на Нютон за апроксимация на корени]: https://en.wikipedia.org/wiki/Newton%27s_method
[секцията с примерите е полезна]:https://en.wikipedia.org/wiki/Newton%27s_method#Examples