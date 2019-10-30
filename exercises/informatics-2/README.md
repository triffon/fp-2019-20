# Упражнения на Информатика, Група 2

За често задавани въпроси вижте [FAQ](#FAQ).

## График

03.10.2019 :school: Упражнение 1 - [Въведение в Scheme](01-introduction-to-scheme/),
[линейна рекурсия и линеен итеративен процес](02-linear-iterative-process/)

10.10.2019 :school: Упражнение 2 - Продължаваме с
[линеен итеративен процес](02-linear-iterative-process/)
и се запознаваме с [дървовидна рекурсия](03-tree-recursion/),
и [функции от по-висок ред](04-higher-order-functions/)

17.10.2019 :school: Упражнение 3 - Използвахме [процерудри от по-висок ред](04-higher-order-functions/), за да построим други процерудри.
Споменахме какво е `let` и как се реализира чрез `lambda`.
А тези, на които им беше скучно се запознаха сами със съставните данни в Scheme,
по-точно [списъци](05-lists/)

24.10.2019 :school: Упражнение 4 - След като разбрахме какво е `lambda` и
как да я ползваме, се запознаваме със [списъци](05-lists/),
за които има много задачи.

31.10.2019 :school: Упражнение 5 - [Наредени двойки и списъци в Scheme](05-lists/)

07.11.2019 :school: Упражнение 6 - Още списъци ...

08.11.2019 :warning: Първо контролно :scream:

14.11.2019 :school: Упражнение 7 - ...

21.11.2019 :school: Упражнение 8 - ...

28.11.2019 :school: Упражнение 9 - ...

05.12.2019 :school: Упражнение 10 - ...

12.12.2019 :school: Упражнение 11 - ...

13.12.2019 :warning: Второ контролно :scream:

19.12.2019 :school: Упражнение 12 - ...

26.12.2019 :christmas_tree: Коледна ваканция :gift: :santa: :deer: - Писане на проекти :woman_technologist: :man_technologist:

02.01.2020 :fireworks: ЧНГ :tada: - Още писане на проекти :man_technologist: :woman_technologist:

09.01.2020 :school: Упражнение 13 - ...

16.01.2020 :school: Упражнение 14 - ...

## FAQ

### За Scheme

#### Кои редактори мога да ползвам за Scheme?

#### Как да накарам VSCode да интерпретира Scheme файлове?

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
