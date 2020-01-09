# Упражнения на Информатика, Група 2

За често задавани въпроси вижте [FAQ](#FAQ).

## График

03.10.2019 :school: Упражнение 1 - [Въведение в Scheme](01-introduction-to-scheme/),
[линейна рекурсия и линеен итеративен процес :arrows_counterclockwise:](02-linear-iterative-process/)

10.10.2019 :school: Упражнение 2 - Продължаваме с
[линеен итеративен процес :loop:](02-linear-iterative-process/)
и се запознаваме с [дървовидна рекурсия](03-tree-recursion/),
и [функции от по-висок ред](04-higher-order-functions/)

17.10.2019 :school: Упражнение 3 - Използвахме [процерудри от по-висок ред](04-higher-order-functions/), за да построим други процерудри.
Споменахме какво е `let` и как се реализира чрез `lambda`.
А тези, на които им беше скучно се запознаха сами със съставните данни в Scheme,
по-точно [списъци](05-lists/)

24.10.2019 :school: Упражнение 4 - След като разбрахме какво е `lambda` и
как да я ползваме, се запознаваме с [наредени двойки и списъци в Scheme](05-lists/),
за които има много задачи.

31.10.2019 :school: Упражнение 5 - Приключваме със задачите върху [списъци :scroll:](05-lists/)
и надграждаме с [матрици :1234:](06-matrices/),
[асоциативни списъци :arrow_right:](07-associative-lists/),
[дървета :deciduous_tree:](08-trees/)
и [графи :atom:](09-graphs/) (чака ни много работа!).
Хората, които са изрешили всички задачи да погледнат [задачите за подготовка за контролно 1](exam-1/).
A за любопитните има няколко задачи върху [функции с произволен брой аргументи](10-apply/).

07.11.2019 :school: Упражнение 6 - Разгледахме примерни решения на задачи
от упражненията, както и решения на [задачи от минали контролни](exam-1/).

08.11.2019 :warning: Първо контролно :scream: - [Качени са примерни решения на задачите от контролното!](exam-1/)

14.11.2019 :school: Упражнение 7 - Ретроспекция на контролното;
Бързо минаване през [асоциативни списъци :arrow_right:](07-associative-lists/),
[дървета :deciduous_tree:](08-trees/), [графи :atom:](09-graphs/) и
[функции с произволен брой аргументи](10-apply/),
за да стигнем до [потоци](11-streams/).

21.11.2019 :sob: Губим упражнение, защото асистента няма да го има. :sob:
Но има достатъчно задачки за решаване! :relieved:

28.11.2019 :school: Упражнение 8 - [Потоци в Scheme](11-streams/) и [въведение в Haskell](12-haskell-intro/)

29.11.2019 :school: Упражнение 9 (отучване) - Продължаваме със задачите от [въведението в Haskell](12-haskell-intro/)
и се задълбочаваме с [по-сложни задачи върху списъци и ламбди](13-haskell-lists-and-lambdas/)

05.12.2019 :school: Упражнение 10 - Решаване на [задачи върху списъци и ламбди в Haskell](13-haskell-lists-and-lambdas/)
и [задачи за подготовка за контролно 2](exam-2/).

12.12.2019 :school: Упражнение 11 - [Подготовка за контролно 2](exam-2/) и [потоци в Haskell](14-haskell-streams/).

13.12.2019 :warning: Второ контролно :scream:

19.12.2019 :school: Упражнение 12 - [Дървета](15-haskell-trees/) и [Двоични наредени дървета](16-haskell-bst/) в Haskell.

26.12.2019 :christmas_tree: Коледна ваканция :gift: :santa: :deer: - Писане на проекти :woman_technologist: :man_technologist:

02.01.2020 :fireworks: ЧНГ :tada: - Още писане на проекти :man_technologist: :woman_technologist:

09.01.2020 :school: Упражнение 13 - [Type Classes](17-type-classes/) и
[Двоични наредени дървета](16-haskell-bst/) в Haskell.

16.01.2020 :school: Упражнение 14 - ...

## FAQ

### За Haskell

#### Как да програмирам на Haskell на моята машина

- VSCode
  - [Setting up Haskell in VS Code on a Unix-based OS](https://medium.com/@dogwith1eye/setting-up-haskell-in-vs-code-on-macos-d2cc1ce9f60a)
  - Extensions like Haskero, Haskell Highliting
- GHCi за интерпретатор
  - Нужно ви е да инсталирате [Haskell Platform](https://www.haskell.org/platform/)
- repl.it/haskell - в Интернет

#### Къде мога да намеря документацията на стандартните функции в езика

- [Hoogle](https://hoogle.haskell.org/)
  - има го и като пакет в `cabal` за offline ползване през терминала

### За Scheme

#### Как да програмирам на Scheme на моята машина

- DrRacket
- VSCode + Racket build task (или команда в терминала)
- repl.it/scheme - в Интернет

#### Как да накарам VSCode да интерпретира Scheme файлове

Отворете `.scm` файла във VSCode и натиснете клавишната комбинация
`Ctrl` + `Shift` + `B`. Първият път ще имате само опцията
`No build task to run found. Configure Build Task...`, изберете я с `Enter`.
След това изберете `Open tasks.json file` и поставете следната конфигурация
или ако вече имате предходни конфигурации, просто добавете новата:

```json
{
  // See https://go.microsoft.com/fwlink/?LinkId=733558
  // for the documentation about the tasks.json format
  "version": "2.0.0",
  "tasks": [
    {
      "label": "run racket",
      "type": "shell",
      "command": "racket -r ${file}",
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
```
